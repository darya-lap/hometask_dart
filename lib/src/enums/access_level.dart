class AccessLevel {
  final String value;

  const AccessLevel._(this.value);

  static const AccessLevel FULL = AccessLevel._('FULL');
  static const AccessLevel REDUCED = AccessLevel._('REDUCED');

  static const List<AccessLevel> values = [
    FULL,
    REDUCED,
  ];

  @override
  String toString() => value;

  static AccessLevel parse(String accessLevel) => values.firstWhere(
          (AccessLevel level) => level.value == accessLevel,
      orElse: () => null
  );
}
