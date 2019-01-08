import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
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

  AdminUser(String id, DateTime regDate, String fullName, String email, AccessLevel level, bool isAdmin, List<Group> groups) : super(id, regDate, fullName, email, groups){
    print('DEBUG: CONSTRUCTOR');
    this.accessLevel = level;
    this.userType = UserType.ADMINISTRATOR;
    this.isAdmin = isAdmin;
    this.groups = groups;
  }

  @override
  Map toJson() => {'id':id, 'regDate':regDate.toString(), 'fullName':fullName, 'email':email, 'isAdmin':isAdmin, 'accessLevel':accessLevel.value, 'userType':userType.value, 'userGroups':json.encode(groups)};

  factory AdminUser.fromJson(Map<String, dynamic> user) {
    return AdminUser(
        user['id'],
        (user['regDate'] != null) ? DateTime.parse(user['regDate']) : null,
        user['fullName'],
        user['email'],
        (user['accessLevel'] != null) ? AccessLevel.parse(user['accessLevel']) : null,
        user['isAdmin'],
        (user['userGroups'] != null) ? parseGroupList(user['userGroups']) : null);
  }

  static List<Group> parseGroupList(List<dynamic> list){
    List<Group> groups = [];
    list.forEach((json){
      groups.add(Group.fromJson(json));
    });
    return groups;
  }
}