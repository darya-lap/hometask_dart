import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';

class CollaboratorUser extends User{
  CollaboratorUser(String id, DateTime regDate, String fullName, String email, List<Group> groups) : super(id, regDate, fullName, email, groups){
    this.userType = UserType.COLLABORATOR;
  }

  @override
  Map toJson() => {'id':id, 'regDate':regDate.toString(), 'fullName':fullName, 'email':email, 'userType':userType.value};

  factory CollaboratorUser.fromJson(Map<String, dynamic> user) => CollaboratorUser(
        user['id'],
        (user['regDate'] != null) ? DateTime.parse(user['regDate']) : null,
        user['fullName'],
        user['email'],
        (user['userGroups'] != null) ? User.parseGroupList(user['userGroups']) : null
    );
}
