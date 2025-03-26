import 'package:bd_phone_validator/bd_phone_validator.dart';

void main() {
  print(BdPhoneValidator.validate("+8801712345678")); // true
  print(BdPhoneValidator.validate("01712345678")); // true
  print(BdPhoneValidator.validate("8801912345678")); // true
  print(BdPhoneValidator.validate("0123456789")); // false
}
