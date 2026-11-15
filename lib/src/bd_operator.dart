/// Mobile network operators operating in Bangladesh.
///
/// Detection is prefix based. Because of Mobile Number Portability a number may
/// since have moved to another operator, so treat the result as a hint.
enum BdOperator {
  /// Grameenphone (013, 017).
  grameenphone('Grameenphone'),

  /// Robi (018).
  robi('Robi'),

  /// Banglalink (014, 019).
  banglalink('Banglalink'),

  /// Teletalk (015).
  teletalk('Teletalk'),

  /// Airtel (016), now merged into Robi but still issued historically.
  airtel('Airtel');

  const BdOperator(this.displayName);

  /// Human readable operator name.
  final String displayName;

  /// Returns the operator for an 11 digit [national] number such as
  /// `01712345678`, or `null` when the prefix is not allocated.
  static BdOperator? fromNational(String national) {
    if (national.length < 3) return null;
    return _byPrefix[national.substring(0, 3)];
  }

  static const Map<String, BdOperator> _byPrefix = {
    '013': grameenphone,
    '014': banglalink,
    '015': teletalk,
    '016': airtel,
    '017': grameenphone,
    '018': robi,
    '019': banglalink,
  };
}
