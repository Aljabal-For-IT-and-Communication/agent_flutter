import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

/// Maps EasyLocalization's current locale to flutter_datetime_picker_plus LocaleType.
/// Fallbacks safely to LocaleType.en on any failure.
LocaleType pickerLocaleFrom(BuildContext context) {
  try {
    final code = context.locale.languageCode.toLowerCase();
    if (code == 'ar') return LocaleType.ar;
    return LocaleType.en;
  } catch (_) {
    return LocaleType.en;
  }
}
