import 'package:app/common/utils/recipient_report.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RecipientReportRow {
  const RecipientReportRow(
      {required this.amount,
      required this.createdAt,
      this.collectType = '',
      this.rechargeType = ''});
  final String amount, createdAt, collectType, rechargeType;
}

/// Kept separate from the native print dialog so pagination and layout can be tested.
Future<Uint8List> buildRecipientReportPdf({
  required String title,
  required RecipientReportFilter filter,
  required List<RecipientReportRow> rows,
  required bool isArabic,
  required String Function(String) translate,
}) async {
  final font =
      pw.Font.ttf(await rootBundle.load('assets/fonts/Cairo-Regular.ttf'));
  final logo = await rootBundle.load('assets/icons/logo1.png');
  final document = pw.Document(title: title, author: 'Alafdal');
  final direction = isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr;
  final total = sumReportAmounts(rows.map((row) => row.amount));
  final collectionTotals = <String, List<String>>{};
  final rechargeTotals = <String, List<String>>{};
  for (final row in rows) {
    if (row.collectType.isNotEmpty && row.collectType != '-') {
      collectionTotals.putIfAbsent(row.collectType, () => []).add(row.amount);
    }
    if (row.rechargeType.isNotEmpty && row.rechargeType != '-') {
      rechargeTotals.putIfAbsent(row.rechargeType, () => []).add(row.amount);
    }
  }
  pw.Widget table(List<String> headers, List<List<String>> data) {
    return pw.TableHelper.fromTextArray(
      headers: isArabic ? headers.reversed.toList() : headers,
      data: isArabic ? data.map((row) => row.reversed.toList()).toList() : data,
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      headerStyle:
          pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 9),
      cellStyle: pw.TextStyle(font: font, fontSize: 9),
      cellPadding: const pw.EdgeInsets.all(5),
      cellAlignment:
          isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
    );
  }

  String date(String value) {
    final parsed = DateTime.tryParse(value);
    return parsed == null
        ? '-'
        : DateFormat('yyyy-MM-dd HH:mm:ss', 'en')
            .format(parsed.toUtc().add(const Duration(hours: 2)));
  }

  pw.Widget numericMetadata(String label, String value) => pw.Row(children: [
        pw.Text('${translate(label)}: '),
        pw.SizedBox(width: 6),
        pw.Expanded(
            child: pw.Text(value,
                textDirection: pw.TextDirection.ltr,
                textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left)),
      ]);

  document.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4, margin: const pw.EdgeInsets.all(30),
    // Long exports may legitimately exceed the package's default 20-page guard.
    maxPages: rows.length + 20,
    textDirection: direction,
    theme: pw.ThemeData.withFont(base: font, bold: font),
    footer: (context) => pw.Align(
        alignment: pw.Alignment.center,
        child: pw.Text('${context.pageNumber} / ${context.pagesCount}',
            textDirection: pw.TextDirection.ltr,
            style: const pw.TextStyle(fontSize: 9))),
    build: (_) => [
      pw.Center(
          child:
              pw.Image(pw.MemoryImage(logo.buffer.asUint8List()), height: 70)),
      pw.SizedBox(height: 10),
      pw.Center(
          child: pw.Text(title,
              style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold))),
      pw.SizedBox(height: 16),
      pw.Text(
          '${translate(filter.category == 'Agent' ? 'Agent' : 'Sales Point')}: ${filter.name}'),
      numericMetadata('Phone', filter.phone),
      pw.SizedBox(height: 8),
      if (filter.startDate.isEmpty)
        pw.Text(translate('All history'))
      else ...[
        numericMetadata('Select date from', filter.startDate),
        numericMetadata('Select date to', filter.endDate),
      ],
      pw.Text(translate('Report times are UTC+2; end time is excluded'),
          style: const pw.TextStyle(fontSize: 8)),
      pw.SizedBox(height: 16),
      if (rows.isEmpty)
        pw.Text(translate('No data available'))
      else
        table(
            [
              '${translate('Amount')} (LYD)',
              translate('Collect Type'),
              translate('Recharge Type'),
              translate('Date')
            ],
            rows
                .map((row) => [
                      row.amount,
                      row.collectType.isEmpty ? '-' : row.collectType,
                      row.rechargeType.isEmpty ? '-' : row.rechargeType,
                      date(row.createdAt)
                    ])
                .toList()),
      if (collectionTotals.isNotEmpty || rechargeTotals.isNotEmpty) ...[
        pw.SizedBox(height: 16),
        pw.Text(translate('Collect and Recharge Details'),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        table([
          translate('Type'),
          translate('Name'),
          '${translate('Total Amount')} (LYD)'
        ], [
          for (final entry in collectionTotals.entries)
            [
              translate('Collect Type'),
              entry.key,
              sumReportAmounts(entry.value)
            ],
          for (final entry in rechargeTotals.entries)
            [
              translate('Recharge Type'),
              entry.key,
              sumReportAmounts(entry.value)
            ],
        ]),
      ],
      pw.SizedBox(height: 16),
      pw.Divider(),
      pw.Text('${translate('Overall Total')}: $total LYD',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
    ],
  ));
  return document.save();
}
