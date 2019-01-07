import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/access_level.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';

class AdminUser extends User{
  bool _isAdmin;
  AccessLevel _accessLevel;

  AccessLevel get accessLevel => _accessLevel;

  set accessLevel(AccessLevel value) {
    _accessLevel = value;
  }

  bool get isAdmin => _isAdmin;

  set isAdmin(bool admin){
    _isAdmin = admin;
  }

  AdminUser(String id, DateTime regDate, String fullName, String email, AccessLevel level, bool isAdmin) : super(id, regDate, fullName, email){
    this.accessLevel = level;
    this.userType = UserType.ADMINISTRATOR;
    this.isAdmin = isAdmin;
  }

  @override
  AdminUser updateFields({DateTime regDate, String fullName, String email, AccessLevel accessLevel}) =>
      AdminUser(this.id, regDate ?? this.regDate, fullName ?? this.fullName, email ?? this.email, accessLevel ?? this.accessLevel, isAdmin ?? this.isAdmin);

  @override
  Map toJson() => {'id':id, 'regDate':regDate.toString(), 'fullName':fullName, 'email':email, 'isAdmin':isAdmin, 'accessLevel':accessLevel.value, 'userType':userType.value};

  factory AdminUser.fromJson(Map<String, dynamic> user) => AdminUser(user['id'], DateTime.parse(user['regDate']), user['fullName'], user['email'], AccessLevel.parse(user['accessLevel']), user['isAdmin']);
}