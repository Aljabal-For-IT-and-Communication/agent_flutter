import 'package:easy_localization/easy_localization.dart';

class _ServerMessageTemplate {
  const _ServerMessageTemplate(this.pattern, this.key, this.argName);

  final RegExp pattern;
  final String key;
  final String argName;
}

const _serverMessagePrefixKeys = <String>[
  'Failed to calculate total amount: ',
  'Failed to fetch top suppliers: ',
  'Comp card update failed: ',
  'Comp card save failed: ',
  'Wallet update failed: ',
  'insufficient balance: ',
  'Unexpected error while finding Comp card:',
  'Card Reprint Update Failed ',
  'Card report creation failed ',
  'Card reports not found ',
  'account Does Not Exist ',
  'account Not Exist ',
  'Agent Not Exist ',
  'Banner Not Exist ',
  'Card Price Type Not Exist ',
  'city Not Exist ',
  'classification Not Exist ',
  'collect Record Not Exist ',
  'message Not Exist ',
  'notification Not Exist ',
  'notification send fail ',
  'Order Not Exist ',
  'parent account Does Not Exist ',
  'pending collection Record Not Exist ',
  'pending recharge Record Not Exist ',
  'recharge Record Not Exist ',
  'region Not Exist ',
  'SalePoint Not Exist ',
  'supplier Not Exist ',
  'Supplier Video Not Exist ',
  'user Not Exist ',
  'Wallet History Not Exist ',
  'Wallet Not Exist ',
  'card created error!',
  'recharge Record created failed!',
];

final _serverMessageTemplates = <_ServerMessageTemplate>[
  _ServerMessageTemplate(
    RegExp(r'^Row\s+(.+)\s+must have at least three columns$'),
    'tmpl.row_must_have_three_columns',
    'row',
  ),
  _ServerMessageTemplate(
    RegExp(r'^Maximum number of cards:\s*(.+)$'),
    'tmpl.maximum_number_of_cards',
    'max',
  ),
  _ServerMessageTemplate(
    RegExp(r'^Sending in\s+(.+)\s+seconds!$'),
    'tmpl.sending_in_seconds',
    'seconds',
  ),
];

const _validatorTagTemplateKeys = <String, String>{
  'required': 'tmpl.validation_required',
  'min': 'tmpl.validation_min',
  'max': 'tmpl.validation_max',
  'len': 'tmpl.validation_len',
  'email': 'tmpl.validation_email',
  'numeric': 'tmpl.validation_numeric',
};

final _ginValidationPattern = RegExp(
  r"Field validation for '([^']+)' failed on the '([^']+)' tag",
);

final _requiredFieldPattern = RegExp(r'^(.+?) is a required field$');
final _minStringPattern = RegExp(
  r'^(.+?) must be at least (\d+) characters? in length$',
);
final _maxStringPattern = RegExp(
  r'^(.+?) must be a maximum of (\d+) characters? in length$',
);
final _lenStringPattern = RegExp(
  r'^(.+?) must be (\d+) characters? in length$',
);
final _minNumberPattern = RegExp(r'^(.+?) must be (.+?) or greater$');
final _maxNumberPattern = RegExp(r'^(.+?) must be (.+?) or less$');
final _lenNumberPattern = RegExp(r'^(.+?) must be equal to (.+?)$');
final _numericPattern = RegExp(r'^(.+?) must be a valid numeric value$');
final _emailPattern = RegExp(r'^(.+?) must be a valid email address$');

/// Translates backend-returned messages.
///
/// Many API messages append dynamic database errors or values to a stable
/// English prefix. For those, translate only the stable prefix and keep the
/// variable tail unchanged.
String trServerMessage(String raw) {
  final value = raw.trimLeft();
  if (value.isEmpty) return value;

  final validationMessage = _translateGinValidationMessage(value);
  if (validationMessage != null) return validationMessage;

  final translatedValidationMessage = _translateValidatorMessage(value);
  if (translatedValidationMessage != null) return translatedValidationMessage;

  for (final template in _serverMessageTemplates) {
    final match = template.pattern.firstMatch(value);
    if (match != null) {
      return template.key.tr(
        namedArgs: {template.argName: match.group(1) ?? ''},
      );
    }
  }

  final direct = value.tr();
  if (direct != value) return direct;

  for (final prefix in _serverMessagePrefixKeys) {
    if (!value.startsWith(prefix) || value.length == prefix.length) {
      continue;
    }

    final translatedPrefix = prefix.tr();
    if (translatedPrefix == prefix) continue;

    final tail = value.substring(prefix.length);
    if (translatedPrefix.endsWith(' ') ||
        tail.startsWith(' ') ||
        tail.startsWith(':')) {
      return '$translatedPrefix$tail';
    }
    return '$translatedPrefix $tail';
  }

  return raw;
}

String? _translateGinValidationMessage(String value) {
  final matches = _ginValidationPattern.allMatches(value).toList();
  if (matches.isEmpty) return null;

  return matches.map((match) {
    final field = _translateValidationField(match.group(1) ?? '');
    final tag = match.group(2) ?? '';
    final key = _validatorTemplateKey(match.group(1) ?? '', tag) ??
        _validatorTagTemplateKeys[tag] ??
        'tmpl.validation_rule';
    final count = _defaultValidatorCount(match.group(1) ?? '', tag);

    return key.tr(namedArgs: {'field': field, 'rule': tag, 'count': count});
  }).join('\n');
}

String? _translateValidatorMessage(String value) {
  final lines = value
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList(growable: false);
  if (lines.isEmpty) return null;

  final translated = <String>[];
  for (final line in lines) {
    final message = _translateSingleValidatorMessage(line);
    if (message == null) return null;
    translated.add(message);
  }

  return translated.join('\n');
}

String? _translateSingleValidatorMessage(String line) {
  RegExpMatch? match = _requiredFieldPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_required'.tr(
      namedArgs: {'field': _translateValidationField(match.group(1) ?? '')},
    );
  }

  match = _minStringPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_min_length'.tr(
      namedArgs: {
        'field': _translateValidationField(match.group(1) ?? ''),
        'count': match.group(2) ?? '',
      },
    );
  }

  match = _maxStringPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_max_length'.tr(
      namedArgs: {
        'field': _translateValidationField(match.group(1) ?? ''),
        'count': match.group(2) ?? '',
      },
    );
  }

  match = _lenStringPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_len_length'.tr(
      namedArgs: {
        'field': _translateValidationField(match.group(1) ?? ''),
        'count': match.group(2) ?? '',
      },
    );
  }

  match = _minNumberPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_min'.tr(
      namedArgs: {
        'field': _translateValidationField(match.group(1) ?? ''),
        'count': match.group(2) ?? '',
      },
    );
  }

  match = _maxNumberPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_max'.tr(
      namedArgs: {
        'field': _translateValidationField(match.group(1) ?? ''),
        'count': match.group(2) ?? '',
      },
    );
  }

  match = _lenNumberPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_len'.tr(
      namedArgs: {
        'field': _translateValidationField(match.group(1) ?? ''),
        'count': match.group(2) ?? '',
      },
    );
  }

  match = _numericPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_numeric'.tr(
      namedArgs: {'field': _translateValidationField(match.group(1) ?? '')},
    );
  }

  match = _emailPattern.firstMatch(line);
  if (match != null) {
    return 'tmpl.validation_email'.tr(
      namedArgs: {'field': _translateValidationField(match.group(1) ?? '')},
    );
  }

  return null;
}

String _translateValidationField(String raw) {
  final field = raw.split('.').last.trim();
  if (field.isEmpty) return 'Field'.tr();

  final fieldKey = 'field.$field';
  final translatedField = fieldKey.tr();
  if (translatedField != fieldKey) return translatedField;

  final readable = field
      .replaceAll('_', ' ')
      .replaceAllMapped(
        RegExp(r'(?<=[a-z0-9])([A-Z])'),
        (match) => ' ${match.group(1)}',
      )
      .trim();
  final translatedReadable = readable.tr();
  return translatedReadable != readable ? translatedReadable : readable;
}

String _defaultValidatorCount(String rawField, String tag) {
  final field = rawField.split('.').last.trim().toLowerCase();
  if (tag == 'min' &&
      (field == 'password' ||
          field == 'repassword' ||
          field == 'pass_word' ||
          field == 'passwd')) {
    return '6';
  }
  return '';
}

String? _validatorTemplateKey(String rawField, String tag) {
  final field = rawField.split('.').last.trim().toLowerCase();
  if (tag == 'min' && (field == 'password' || field == 'repassword')) {
    return 'tmpl.validation_min_length';
  }
  return null;
}
