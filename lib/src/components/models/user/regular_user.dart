import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';

class RegularUser extends User{
  bool _isAdmin;

  bool get isAdmin => _isAdmin;

  set isAdmin(bool admin){
    _isAdmin = admin;
  }

  RegularUser(String id, DateTime regDate, String fullName, String email, bool isAdmin, List<Group> groups) : super(id, regDate, fullName, email, groups){
    this.userType = UserType.REGULAR;
    this.isAdmin = isAdmin;
  }

  @override
  Map toJson() => {'id':id, 'regDate':regDate.toString(), 'fullName':fullName, 'email':email, 'isAdmin':isAdmin, 'userType':userType.value};

  factory RegularUser.fromJson(Map<String, dynamic> user) => RegularUser(
      user['id'],
      (user['regDate'] != null) ? DateTime.parse(user['regDate']) : null,
      user['fullName'],
      user['email'],
      user['isAdmin'],
      (user['userGroups'] != null) ? User.parseGroupList(user['userGroups']) : null);
}