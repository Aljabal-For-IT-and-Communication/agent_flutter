import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/date.dart';
import 'package:intl/intl.dart';

/// A captured filter is shared by the request and its PDF header.
class RecipientReportFilter {
  const RecipientReportFilter(
      {required this.category,
      required this.id,
      required this.name,
      required this.phone,
      required this.startDate,
      required this.endDate});

  final String category, name, phone, startDate, endDate;
  final int? id;

  String? get validationError {
    if (id == null || id! <= 0) return 'Please select an agent or sale point';
    if (startDate.isEmpty && endDate.isEmpty) return null;
    if (startDate.isEmpty || endDate.isEmpty) return 'Please select both dates';
    try {
      final format = DateFormat('yyyy-MM-dd HH:mm:ss', 'en');
      final start = format.parseStrict(replaceArabicNumbers(startDate));
      final end = format.parseStrict(replaceArabicNumbers(endDate));
      if (!end.isAfter(start)) return 'End date must be after start date';
    } on FormatException {
      return 'Invalid report date';
    }
    return null;
  }

  TransferRecordListRequestEntity request(int page) =>
      TransferRecordListRequestEntity(
          id: id,
          category: category,
          page: page,
          startDate: replaceArabicNumbers(startDate),
          endDate: replaceArabicNumbers(endDate));
}

/// Exact decimal addition, without converting currency amounts to doubles.
String sumReportAmounts(Iterable<String> amounts) {
  var total = BigInt.zero;
  var scale = 0;
  for (final amount in amounts) {
    final match = RegExp(r'^([+-]?)(\d+)(?:\.(\d+))?$').firstMatch(amount);
    if (match == null) throw FormatException('Invalid report amount', amount);
    final fraction = match.group(3) ?? '';
    var value = BigInt.parse('${match.group(2)}$fraction');
    if (match.group(1) == '-') value = -value;
    if (fraction.length > scale) {
      total *= BigInt.from(10).pow(fraction.length - scale);
      scale = fraction.length;
    }
    total += value * BigInt.from(10).pow(scale - fraction.length);
  }
  final sign = total.isNegative ? '-' : '';
  var digits = total.abs().toString().padLeft(scale + 1, '0');
  if (scale > 0) {
    digits =
        '${digits.substring(0, digits.length - scale)}.${digits.substring(digits.length - scale)}';
    digits = digits
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
  return '$sign$digits';
}
