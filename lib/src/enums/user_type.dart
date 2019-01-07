class UserType {
  final String value;

  const UserType._(this.value);

  static const UserType COLLABORATOR = UserType._('Collaborator');
  static const UserType REGULAR = UserType._('Regular');
  static const UserType ADMINISTRATOR = UserType._('Administrator');

  static const List<UserType> values = [
    COLLABORATOR,
    REGULAR,
    ADMINISTRATOR,
  ];

  @override
  String toString() => value;

  static UserType parse(String userType) => values.firstWhere(
          (UserType type) => type.value == userType,
      orElse: () => null
  );
}
