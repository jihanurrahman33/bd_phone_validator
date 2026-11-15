import 'bd_operator.dart';

/// An immutable, validated Bangladeshi mobile number.
///
/// Obtain one with [BdPhone.tryParse]; an instance always holds a valid number.
class BdPhone {
  const BdPhone._(this.national);

  /// Strict form: optional `+88` / `88`, then `01[3-9]` and 8 digits.
  static final RegExp _strictPattern = RegExp(r'^(?:\+88|88)?(01[3-9]\d{8})$');

  /// Lenient form: additionally accepts `0088` after cleaning the input.
  static final RegExp _lenientPattern =
      RegExp(r'^(?:\+88|88|0088)?(01[3-9]\d{8})$');

  static final RegExp _separators = RegExp(r'[\s\-.()]');

  /// 11 digit national number, e.g. `01712345678`.
  final String national;

  /// The operator derived from the number prefix.
  BdOperator get operator =>
      BdOperator.fromNational(national) ??
      (throw StateError('Unreachable: validated prefix $national'));

  /// E.164 form, e.g. `+8801712345678`.
  String get e164 => '+88$national';

  /// Readable form, e.g. `01712-345678`.
  String get formatted =>
      '${national.substring(0, 5)}-${national.substring(5)}';

  /// Privacy friendly form, e.g. `017XX-XXX678`.
  String get masked =>
      '${national.substring(0, 3)}XX-XXX${national.substring(8)}';

  /// Parses [input] into a [BdPhone], or returns `null` when it is not a valid
  /// Bangladeshi mobile number.
  ///
  /// With [strict] `true` only the exact legacy formats are accepted. Otherwise
  /// whitespace, `-`, `.`, parentheses, Bangla digits and a `0088` prefix are
  /// tolerated.
  static BdPhone? tryParse(String input, {bool strict = false}) {
    final match = strict
        ? _strictPattern.firstMatch(input)
        : _lenientPattern.firstMatch(_clean(input));
    final national = match?.group(1);
    return national == null ? null : BdPhone._(national);
  }

  static String _clean(String input) {
    final buffer = StringBuffer();
    for (final unit in input.replaceAll(_separators, '').runes) {
      final isBanglaDigit = unit >= _banglaZero && unit <= _banglaZero + 9;
      buffer.writeCharCode(isBanglaDigit ? 0x30 + unit - _banglaZero : unit);
    }
    return buffer.toString();
  }

  static const int _banglaZero = 0x09E6;

  @override
  bool operator ==(Object other) =>
      other is BdPhone && other.national == national;

  @override
  int get hashCode => national.hashCode;

  @override
  String toString() => 'BdPhone($national, ${operator.displayName})';
}
