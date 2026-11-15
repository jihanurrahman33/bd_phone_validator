## 1.1.0

- **Pure Dart:** removed the unnecessary `flutter` SDK dependency. Now usable
  in server and CLI projects. Minimum SDK is Dart 3.0.
- Added `BdOperator` enum and `BdPhoneValidator.detectOperator`.
- Added `BdPhone` value object via `BdPhoneValidator.tryParse` (`national`,
  `e164`, `operator`, `formatted`, `masked`).
- Added `normalize` and `toE164`.
- Added lenient parsing (`strict: false`): spaces, `-`, `.`, parentheses,
  `0088` prefix and Bangla digits.
- Added `BdPhoneValidator.formValidator` for `TextFormField`.
- `validate` is unchanged by default (strict), fully backward compatible.
- Removed leftover template class `Awesome`.
- Added CI, automated publishing workflow, Dependabot, topics, new README,
  dartdoc and more tests.

## 1.0.3

- Documentation and test improvements.

## 1.0.2

- Optimized regex, added unit tests, updated docs.

## 1.0.1

- Fixed incorrect regex syntax.

## 1.0.0

- Initial release.
