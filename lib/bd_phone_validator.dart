library bd_phone_validator;

/// A Dart package for validating Bangladeshi phone numbers.
class BdPhoneValidator {
  /// Regular expression for Bangladeshi phone number validation.
  static final RegExp _regExp = RegExp(r'^(?:\+88|88)?(01[3-9]\d{8})$');

  /// Validates a phone number.
  ///
  /// Returns `true` if the phone number is valid, otherwise `false`.
  static bool validate(String phoneNumber) {
    return _regExp.hasMatch(phoneNumber);
  }
}
