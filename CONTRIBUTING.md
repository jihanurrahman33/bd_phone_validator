# Contributing

1. Fork and create a branch.
2. Write a failing test first, then the fix or feature.
3. Run before pushing:
   ```bash
   dart format .
   dart analyze --fatal-infos
   dart test
   ```
4. Add a `CHANGELOG.md` entry and open a PR.

## Releasing (maintainer)

1. Bump `version` in `pubspec.yaml` and finalize the changelog.
2. Merge to `main`, then `git tag vX.Y.Z && git push --tags`.
3. The `publish.yml` workflow publishes to pub.dev (automated publishing must be enabled once in the package Admin tab).

## Operator prefix updates

If BTRC allocates or reassigns a prefix, update `lib/src/bd_operator.dart`
and the table in `test/` and link the source in the PR.

## Monthly checklist

- Triage issues and PRs
- Merge Dependabot updates
- Check CI against the latest stable Dart
