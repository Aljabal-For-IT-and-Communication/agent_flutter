import 'dart:convert';
import 'dart:math';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/common/widgets/toast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// SHA256
String duSHA256(String input) {
  String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO'; // 加盐
  var bytes = utf8.encode(input + salt);
  var digest = sha256.convert(bytes);

  return digest.toString();
}

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

String getOrderNumber() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

Future<bool> request_permission(Permission permission) async {
  var permission_status = await permission.status;
  print("permission_status------${permission_status}");
  if (permission_status != PermissionStatus.granted) {
    //here
    var status = await permission.request();

    if (status != PermissionStatus.granted) {
      //here
      print("denied");
      toastInfo(msg: "Please open the setting page to set permissions");
      await openAppSettings();
      return false;
    }
  }

  return true;
}

Future<bool> printPdf(TransferCollectionData item,
    {String businessName = ""}) async {
  final pdf = pw.Document();
  final font = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");

  final imageBytes = await rootBundle.load('assets/icons/logo1.png');
  final image = pw.MemoryImage(imageBytes.buffer.asUint8List());

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      build: (pw.Context context) {
        return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Center(
                child: pw.Image(image, width: 150, height: 150),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text("Order ID:  ${item.id}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                    "Name:  ${businessName == "" ? item.name : businessName}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Phone Number:  ${item.phone}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Amount:  ${item.amount}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Collect Type:  ${item.collectTypeName ?? "-"}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                    "Recharge Type:  ${item.rechargeTypeName ?? "-"}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Time:  ${timeFormated(item.createdAt)}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
            ]); // Center
      }));

  return await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}

Future<bool> printCollectionReportPdf(
    List<AgentCollectRecordData> collectionList) async {
  bool isArabic = "No".tr() != "No";

  collectionList.sort((a, b) {
    int cmp = (a.salesPointId ?? 0).compareTo(b.salesPointId ?? 0);
    if (cmp != 0) return cmp;
    cmp = (a.toAgentId ?? 0).compareTo(b.toAgentId ?? 0);
    if (cmp != 0) return cmp;
    return (a.id ?? 0).compareTo(b.id ?? 0);
  });

  final pdf = pw.Document();
  final font = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
  final ttf = pw.Font.ttf(font);
  final imageBytes = await rootBundle.load('assets/icons/logo1.png');
  final image = pw.MemoryImage(imageBytes.buffer.asUint8List());

  List<pw.Widget> widgets = [];

  // Header with logo and title
  widgets.add(pw.Center(child: pw.Image(image, width: 150, height: 150)));
  widgets.add(pw.SizedBox(height: 20));
  widgets.add(pw.Center(
      child: pw.Text("Collection Report".tr(),
          style: pw.TextStyle(font: ttf, fontSize: 24))));
  widgets.add(pw.SizedBox(height: 20));

  double overallTotal = 0;

  if (collectionList.isEmpty) {
    widgets.add(pw.Center(
        child: pw.Text("No data available".tr(),
            style: pw.TextStyle(font: ttf, fontSize: 16))));
  } else {
    // Grouping logic
    List<List<AgentCollectRecordData>> groups = [];
    List<String> groupTitles = [];
    List<AgentCollectRecordData> currentGroup = [];
    String? currentTitle;

    for (var item in collectionList) {
      String title;
      if (item.salesPointId != null && item.salesPointId != 0) {
        title = "${"Sales Point".tr()} : ${item.businessName}";
      } else if (item.toAgentId != null && item.toAgentId != 0) {
        title = "${"Agent".tr()} : ${item.firstName}";
      } else {
        title = "Other".tr();
      }
      if (currentTitle == null) {
        currentTitle = title;
      }
      if (title != currentTitle) {
        groups.add(currentGroup);
        groupTitles.add(currentTitle);
        currentGroup = [];
        currentTitle = title;
      }
      currentGroup.add(item);
    }
    // Add last group
    if (currentGroup.isNotEmpty && currentTitle != null) {
      groups.add(currentGroup);
      groupTitles.add(currentTitle);
    }

    // Build PDF for each group
    for (int i = 0; i < groups.length; i++) {
      final group = groups[i];
      final title = groupTitles[i];
      widgets.add(pw.Header(
          level: 1,
          text: title.tr(),
          textStyle: pw.TextStyle(
              font: ttf, fontSize: 18, fontWeight: pw.FontWeight.bold)));

      final headers = [
        'Amount'.tr(),
        'Collect Type'.tr(),
        'Recharge Type'.tr(),
        'Date'.tr()
      ];
      final data = group.map((item) {
        final collectType =
            (item.collectTypeName != null && item.collectTypeName!.isNotEmpty)
                ? item.collectTypeName!
                : '-';
        final rechargeType =
            (item.rechargeTypeName != null && item.rechargeTypeName!.isNotEmpty)
                ? item.rechargeTypeName!
                : '-';

        return [
          item.amount ?? '0',
          collectType,
          rechargeType,
          timeFormated(item.updatedAt)
        ];
      }).toList();

      widgets.add(pw.TableHelper.fromTextArray(
        headers: headers,
        data: data,
        headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
        cellStyle: pw.TextStyle(font: ttf),
        headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
        cellAlignment: pw.Alignment.center,
        cellAlignments: isArabic
            ? {
                0: pw.Alignment.centerRight,
                1: pw.Alignment.center,
                2: pw.Alignment.center,
                3: pw.Alignment.centerLeft,
              }
            : {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.center,
                2: pw.Alignment.center,
                3: pw.Alignment.centerRight,
              },
      ));

      double groupTotal = group.fold(
          0, (sum, item) => sum + (double.tryParse(item.amount ?? '0') ?? 0));
      widgets.add(pw.SizedBox(height: 10));
      widgets.add(pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Text("${"Subtotal".tr()}: ${groupTotal.toStringAsFixed(2)}",
            style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
      ));
      widgets.add(pw.SizedBox(height: 20));
      overallTotal += groupTotal;
    }

    // Calculate collectType and rechargeType totals (excluding items without names)
    Map<String, double> collectTypeTotals = {};
    Map<String, double> rechargeTypeTotals = {};
    double validItemsTotal = 0;
    
    for (var item in collectionList) {
      double amount = double.tryParse(item.amount ?? '0') ?? 0;
      
      // Calculate collectType totals
      if (item.collectTypeName != null && 
          item.collectTypeName!.isNotEmpty && 
          item.collectTypeName != '-') {
        String collectType = item.collectTypeName!;
        collectTypeTotals.update(collectType, (value) => value + amount, 
            ifAbsent: () => amount);
        validItemsTotal += amount;
      }
      
      // Calculate rechargeType totals
      if (item.rechargeTypeName != null && 
          item.rechargeTypeName!.isNotEmpty && 
          item.rechargeTypeName != '-') {
        String rechargeType = item.rechargeTypeName!;
        rechargeTypeTotals.update(rechargeType, (value) => value + amount, 
            ifAbsent: () => amount);
      }
    }

    // Add combined summary table before overall total
    if (collectTypeTotals.isNotEmpty || rechargeTypeTotals.isNotEmpty) {
      widgets.add(pw.Header(
          level: 2,
          text: "Collect and Recharge Details".tr(),
          textStyle: pw.TextStyle(
              font: ttf, fontSize: 16, fontWeight: pw.FontWeight.bold)));

      // Create combined data for the table
      final summaryHeaders = ['Type'.tr(), 'Name'.tr(), 'Total Amount'.tr()];
      List<List<String>> summaryData = [];

      // Add collectType entries
      collectTypeTotals.entries.forEach((entry) {
        summaryData.add([
          'Collect Type'.tr(),
          entry.key,
          entry.value.toStringAsFixed(2)
        ]);
      });

      // Add rechargeType entries
      rechargeTypeTotals.entries.forEach((entry) {
        summaryData.add([
          'Recharge Type'.tr(),
          entry.key,
          entry.value.toStringAsFixed(2)
        ]);
      });

     

      widgets.add(pw.TableHelper.fromTextArray(
        headers: summaryHeaders,
        data: summaryData,
        headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
        cellStyle: pw.TextStyle(font: ttf),
        headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
        cellAlignment: pw.Alignment.center,
        cellAlignments: isArabic
            ? {
                0: pw.Alignment.centerRight,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerLeft,
              }
            : {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerRight,
              },
      ));

      widgets.add(pw.SizedBox(height: 20));
    }
  }

  // Overall Total
  widgets.add(pw.Divider());
  widgets.add(pw.SizedBox(height: 10));
  widgets.add(pw.Align(
    alignment: isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
    child: pw.Text(
        "${"Overall Total".tr()}: ${overallTotal.toStringAsFixed(2)}",
        style: pw.TextStyle(
            font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold)),
  ));

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      build: (pw.Context context) {
        return widgets;
      }));

  return await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}