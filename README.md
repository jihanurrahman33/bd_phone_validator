# 📱 bd_phone_validator

[![pub package](https://img.shields.io/pub/v/bd_phone_validator.svg)](https://pub.dev/packages/bd_phone_validator)
[![CI](https://github.com/jihanurrahman33/bd_phone_validator/actions/workflows/ci.yml/badge.svg)](https://github.com/jihanurrahman33/bd_phone_validator/actions/workflows/ci.yml)
[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Validate, normalize, format and detect the operator of Bangladeshi mobile
numbers. Pure Dart, zero dependencies, works in Flutter, server and CLI.

## Features

- ✅ Validate `01XXXXXXXXX`, `8801XXXXXXXXX`, `+8801XXXXXXXXX` (prefixes `013`–`019`)
- 🔁 Normalize to `01712345678` or E.164 `+8801712345678`
- 📡 Operator detection: Grameenphone, Robi, Banglalink, Teletalk, Airtel
- 🧹 Lenient mode: spaces, dashes, parentheses, `0088` prefix, Bangla digits (`০১৭…`)
- 🎨 Formatting (`01712-345678`) and masking (`017XX-XXX678`)
- 📝 Ready-made `TextFormField` validator, no Flutter dependency

## Install

```yaml
dependencies:
  bd_phone_validator: ^1.1.0
```

## Usage

```dart
import 'package:bd_phone_validator/bd_phone_validator.dart';

BdPhoneValidator.validate('+8801712345678');            // true
BdPhoneValidator.validate('017-1234-5678');             // false (strict default)
BdPhoneValidator.validate('017-1234-5678', strict: false); // true

BdPhoneValidator.normalize('+880 1712-345678');  // 01712345678
BdPhoneValidator.toE164('01712345678');          // +8801712345678
BdPhoneValidator.detectOperator('01812345678');  // BdOperator.robi

final phone = BdPhoneValidator.tryParse('০১৭১২৩৪৫৬৭৮');
phone?.operator.displayName; // Grameenphone
phone?.formatted;            // 01712-345678
phone?.masked;               // 017XX-XXX678
```

### Flutter forms

```dart
TextFormField(
  keyboardType: TextInputType.phone,
  validator: BdPhoneValidator.formValidator(
    invalidMessage: 'সঠিক মোবাইল নম্বর দিন',
  ),
)
```

## Strict vs lenient

| Method | Default |
|---|---|
| `validate` | strict (unchanged since 1.0, fully backward compatible) |
| `tryParse`, `normalize`, `toE164`, `detectOperator`, `formValidator` | lenient |

## Note on operators

Detection is prefix based. With Mobile Number Portability a number may have
moved to another operator, so treat the result as a hint.

## Contributing

Issues and PRs are welcome, see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT, see [LICENSE](LICENSE).
