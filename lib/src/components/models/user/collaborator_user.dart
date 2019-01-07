import 'package:angular_tour_of_heroes/src/components/models/user/regular_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';

class CollaboratorUser extends User{
  CollaboratorUser(String id, DateTime regDate, String fullName, String email) : super(id, regDate, fullName, email){
    this.userType = UserType.COLLABORATOR;
  }

  @override
  CollaboratorUser updateFields({DateTime regDate, String fullName, String email}) =>
      CollaboratorUser(this.id, regDate ?? this.regDate, fullName ?? this.fullName, email ?? this.email);

  @override
  Map toJson() => {'id':id, 'regDate':regDate.toString(), 'fullName':fullName, 'email':email, 'userType':userType.value};

  factory CollaboratorUser.fromJson(Map<String, dynamic> user) => CollaboratorUser(user['id'], DateTime.parse(user['regDate']), user['fullName'], user['email']);

}
