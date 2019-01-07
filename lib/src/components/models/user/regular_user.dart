import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';

class RegularUser extends User{
  final bool _isAdmin;

  bool get isAdmin => _isAdmin;

  set isAdmin(bool admin){
    isAdmin = admin;
  }

  RegularUser(String id, DateTime regDate, String fullName, String email, bool isAdmin) : super(id, regDate, fullName, email){
    this.userType = UserType.REGULAR;
    this.isAdmin = isAdmin;
  }

  @override
  RegularUser updateFields({DateTime regDate, String fullName, String email, String isAdmin}) =>
      RegularUser(this.id, regDate ?? this.regDate, fullName ?? this.fullName, email ?? this.email, isAdmin ?? this.isAdmin);

  @override
  Map toJson() => {'id':id, 'regDate':regDate.toString(), 'fullName':fullName, 'email':email, 'isAdmin':isAdmin, 'userType':userType.value};

  factory RegularUser.fromJson(Map<String, dynamic> user) => RegularUser(user['id'], DateTime.parse(user['regDate']), user['fullName'], user['email'], user['isAdmin']);

}