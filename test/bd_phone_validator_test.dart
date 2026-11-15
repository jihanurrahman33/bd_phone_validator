import 'package:bd_phone_validator/bd_phone_validator.dart';
import 'package:test/test.dart';

void main() {
  group('validate (strict, backward compatible)', () {
    test('accepts +88, 88 and no prefix', () {
      expect(BdPhoneValidator.validate('+8801712345678'), isTrue);
      expect(BdPhoneValidator.validate('01712345678'), isTrue);
      expect(BdPhoneValidator.validate('8801912345678'), isTrue);
    });

    test('rejects wrong length, wrong prefix and noise', () {
      expect(BdPhoneValidator.validate('0123456789'), isFalse);
      expect(BdPhoneValidator.validate('1234567890'), isFalse);
      expect(BdPhoneValidator.validate('+881112345678'), isFalse);
      expect(BdPhoneValidator.validate('01212345678'), isFalse);
      expect(BdPhoneValidator.validate('017123456789'), isFalse);
      expect(BdPhoneValidator.validate(''), isFalse);
      expect(BdPhoneValidator.validate(' 01712345678'), isFalse);
      expect(BdPhoneValidator.validate('017-1234-5678'), isFalse);
      expect(BdPhoneValidator.validate('০১৭১২৩৪৫৬৭৮'), isFalse);
    });

    test('rejects trailing newline', () {
      expect(BdPhoneValidator.validate('01712345678\n'), isFalse);
    });
  });

  group('validate (strict: false)', () {
    const ok = [
      '+880 1712-345678',
      '+88-017-1234-5678',
      '(017) 1234 5678',
      '017.1234.5678',
      '008801712345678',
      '০১৭১২৩৪৫৬৭৮',
      '+৮৮০১৭১২৩৪৫৬৭৮',
      '  01712345678  ',
    ];
    for (final input in ok) {
      test('accepts "$input"', () {
        expect(BdPhoneValidator.validate(input, strict: false), isTrue);
      });
    }

    const bad = [
      '',
      '   ',
      'abc',
      '0171234',
      '+8801212345678',
      '++8801712345678'
    ];
    for (final input in bad) {
      test('rejects "$input"', () {
        expect(BdPhoneValidator.validate(input, strict: false), isFalse);
      });
    }
  });

  group('normalize', () {
    test('returns 11-digit national form', () {
      expect(BdPhoneValidator.normalize('+8801712345678'), '01712345678');
      expect(BdPhoneValidator.normalize('8801912345678'), '01912345678');
      expect(BdPhoneValidator.normalize('+880 1712-345678'), '01712345678');
      expect(BdPhoneValidator.normalize('০১৭১২৩৪৫৬৭৮'), '01712345678');
    });

    test('returns null for invalid input', () {
      expect(BdPhoneValidator.normalize('nope'), isNull);
      expect(BdPhoneValidator.normalize('01212345678'), isNull);
    });
  });

  group('toE164', () {
    test('adds +88', () {
      expect(BdPhoneValidator.toE164('01712345678'), '+8801712345678');
      expect(BdPhoneValidator.toE164('+8801712345678'), '+8801712345678');
    });
    test('null when invalid', () {
      expect(BdPhoneValidator.toE164('123'), isNull);
    });
  });

  group('detectOperator', () {
    const table = {
      '01312345678': BdOperator.grameenphone,
      '01412345678': BdOperator.banglalink,
      '01512345678': BdOperator.teletalk,
      '01612345678': BdOperator.airtel,
      '01712345678': BdOperator.grameenphone,
      '01812345678': BdOperator.robi,
      '01912345678': BdOperator.banglalink,
    };
    table.forEach((number, operator) {
      test('$number -> ${operator.name}', () {
        expect(BdPhoneValidator.detectOperator(number), operator);
        expect(BdPhoneValidator.detectOperator('+88$number'), operator);
      });
    });

    test('null for invalid number', () {
      expect(BdPhoneValidator.detectOperator('01212345678'), isNull);
    });

    test('operator has display name', () {
      expect(BdOperator.grameenphone.displayName, 'Grameenphone');
      expect(BdOperator.teletalk.displayName, 'Teletalk');
    });
  });

  group('tryParse / BdPhone', () {
    test('parses a valid number', () {
      final phone = BdPhoneValidator.tryParse('+880 1712-345678');
      expect(phone, isNotNull);
      expect(phone!.national, '01712345678');
      expect(phone.e164, '+8801712345678');
      expect(phone.operator, BdOperator.grameenphone);
      expect(phone.formatted, '01712-345678');
      expect(phone.masked, '017XX-XXX678');
    });

    test('returns null when invalid', () {
      expect(BdPhoneValidator.tryParse('hello'), isNull);
    });

    test('value equality and toString', () {
      final a = BdPhoneValidator.tryParse('01712345678');
      final b = BdPhoneValidator.tryParse('+8801712345678');
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a.toString(), contains('01712345678'));
    });
  });

  group('formValidator', () {
    test('returns null for valid input', () {
      final v = BdPhoneValidator.formValidator();
      expect(v('01712345678'), isNull);
      expect(v('+880 1712-345678'), isNull);
    });

    test('returns messages for empty and invalid input', () {
      final v = BdPhoneValidator.formValidator();
      expect(v(null), 'Phone number is required');
      expect(v(''), 'Phone number is required');
      expect(v('123'), 'Enter a valid Bangladeshi phone number');
    });

    test('supports custom messages and optional fields', () {
      final v = BdPhoneValidator.formValidator(
        required: false,
        requiredMessage: 'দিন',
        invalidMessage: 'ভুল',
      );
      expect(v(''), isNull);
      expect(v(null), isNull);
      expect(v('123'), 'ভুল');
    });

    test('strict mode rejects separators', () {
      final v = BdPhoneValidator.formValidator(strict: true);
      expect(v('017-1234-5678'), isNotNull);
    });
  });
}
