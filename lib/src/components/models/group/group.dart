import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';

class Group{
  int _id;
  String _name;
  List<User> _users;
  List<User> _admins;

  Group(int id, String name, List<User> users, List<User> admins){
    this.id = id;
    this.name = name;
    this.users = users;
    this.admins = admins;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


  List<User> get users => _users;

  set users(List<User> value) {
    _users = value;
  }

  List<User> get admins => _admins;

  set admins(List<User> value) {
    _admins = value;
  }

  Map toJson() => {'id':id, 'name':name};

  factory Group.fromJson(Map<String, dynamic> group) {
    return Group(
        group['id'],
        group['name'],
        (group['users'] != null) ? parseUserList(group['users']) : null,
        (group['admins'] != null) ? parseUserList(group['admins']) : null,
    );
  }

  static List<User> parseUserList(List<dynamic> list){
    List<User> users = [];
    list.forEach((json){
      users.add(UserService.fromJson(json));
    });
    return users;
  }

}
