import 'bd_operator.dart';
import 'bd_phone.dart';

/// Validation, normalization and detection helpers for Bangladeshi mobile
/// numbers.
abstract final class BdPhoneValidator {
  /// Returns `true` if [phoneNumber] is a valid Bangladeshi mobile number.
  ///
  /// By default ([strict] `true`) only `01XXXXXXXXX`, `8801XXXXXXXXX` and
  /// `+8801XXXXXXXXX` are accepted. Pass `strict: false` to also accept
  /// separators, Bangla digits and a `0088` prefix.
  static bool validate(String phoneNumber, {bool strict = true}) =>
      BdPhone.tryParse(phoneNumber, strict: strict) != null;

  /// Parses [input] leniently (or exactly when [strict] is `true`).
  static BdPhone? tryParse(String input, {bool strict = false}) =>
      BdPhone.tryParse(input, strict: strict);

  /// Returns the 11 digit national form (`01712345678`), or `null` if invalid.
  static String? normalize(String input) => tryParse(input)?.national;

  /// Returns the E.164 form (`+8801712345678`), or `null` if invalid.
  static String? toE164(String input) => tryParse(input)?.e164;

  /// Returns the operator of [input], or `null` if the number is invalid.
  static BdOperator? detectOperator(String input) => tryParse(input)?.operator;

  /// Builds a validator usable as `TextFormField.validator`, without
  /// depending on Flutter.
  ///
  /// Empty input yields [requiredMessage] when [required] is `true`, and is
  /// accepted otherwise. Non-empty invalid input yields [invalidMessage].
  static String? Function(String?) formValidator({
    bool required = true,
    bool strict = false,
    String requiredMessage = 'Phone number is required',
    String invalidMessage = 'Enter a valid Bangladeshi phone number',
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return required ? requiredMessage : null;
      }
      return validate(value, strict: strict) ? null : invalidMessage;
    };
  }
}
