import 'package:test/test.dart';
import 'package:bd_phone_validator/bd_phone_validator.dart';

void main() {
  group('PhoneValidator Tests', () {
    test('Valid Bangladeshi Numbers', () {
      expect(BdPhoneValidator.validate("+8801712345678"), isTrue);
      expect(BdPhoneValidator.validate("01712345678"), isTrue);
      expect(BdPhoneValidator.validate("8801912345678"), isTrue);
    });

    test('Invalid Numbers', () {
      expect(BdPhoneValidator.validate("0123456789"), isFalse);
      expect(BdPhoneValidator.validate("1234567890"), isFalse);
      expect(BdPhoneValidator.validate("+881112345678"), isFalse);
    });
  });
}
