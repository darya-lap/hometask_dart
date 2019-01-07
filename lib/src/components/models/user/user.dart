import 'package:angular_tour_of_heroes/src/components/models/user/regular_user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';

abstract class User{
  final String _id;
  DateTime _regDate;
  String _fullName;
  String _email;
  UserType _userType;

  User(this._id, DateTime regDate, String fullName, String email){
    this.regDate = regDate;
    this.fullName = fullName;
    this.email = email;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  DateTime get regDate => _regDate;

  set regDate(DateTime value) {
    _regDate = value;
  }

  String get id => _id;


  UserType get userType => _userType;

  set userType(UserType value) {
    _userType = value;
  }

  User updateFields({DateTime regDate, String fullName, String email});

  Map toJson();

  static int userIdToInt(id) => id is int ? id : int.parse(id);
}