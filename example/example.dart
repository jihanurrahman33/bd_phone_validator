// ignore_for_file: avoid_print
import 'package:bd_phone_validator/bd_phone_validator.dart';

void main() {
  // Backward-compatible strict validation.
  print(BdPhoneValidator.validate('+8801712345678')); // true
  print(BdPhoneValidator.validate('0123456789')); // false

  // Lenient validation: separators and Bangla digits.
  print(BdPhoneValidator.validate('+880 1712-345678', strict: false)); // true
  print(BdPhoneValidator.validate('০১৭১২৩৪৫৬৭৮', strict: false)); // true

  // Normalize / E.164.
  print(BdPhoneValidator.normalize('+8801712345678')); // 01712345678
  print(BdPhoneValidator.toE164('01712345678')); // +8801712345678

  // Operator detection.
  print(BdPhoneValidator.detectOperator('01812345678')); // BdOperator.robi

  // Rich parsing.
  final phone = BdPhoneValidator.tryParse('+880 1712-345678');
  if (phone != null) {
    print(phone.operator.displayName); // Grameenphone
    print(phone.formatted); // 01712-345678
    print(phone.masked); // 017XX-XXX678
  }

  // Use with a Flutter TextFormField: validator: BdPhoneValidator.formValidator()
  final validator = BdPhoneValidator.formValidator();
  print(validator('123')); // Enter a valid Bangladeshi phone number
}
