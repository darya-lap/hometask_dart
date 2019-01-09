import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';

abstract class User{
  final String _id;
  DateTime _regDate;
  String _fullName;
  String _email;
  UserType _userType;
  List<Group> _groups;

  User(this._id, DateTime regDate, String fullName, String email, List<Group> groups){
    this.regDate = regDate;
    this.fullName = fullName;
    this.email = email;
    this.groups = groups;
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


  List<Group> get groups => _groups;

  set groups(List<Group> value) {
    _groups = value;
  }

  Map toJson();

  static List<Group> parseGroupList(List<dynamic> list){
    List<Group> groups = [];
    list.forEach((json){
      groups.add(Group.fromJson(json));
    });
    return groups;
  }
}