import 'dart:async';
import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/user/admin_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/collaborator_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/regular_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';
import 'package:http/http.dart';


class UserService {
  static final _headers = {'Content-Type': 'application/json'};
  static const _usersUrl = 'api/users'; // URL to web API

  final Client _http;

  UserService(this._http);

  Future<List<User>> getAll() async {
    try {
      print('DEBUG: memememe');
      final response = await _http.get(_usersUrl);
      print('DEBUG: $response');
      final users = (_extractData(response) as List)
          .map((json) => fromJson(json))
          .toList();
      return users;
    } catch (e) {
      throw _handleError(e);
    }
  }

  static User fromJson(Map<String, dynamic> user){
    final userType = UserType.parse(user['userType']);
    switch(userType){
      case UserType.COLLABORATOR:
        return CollaboratorUser.fromJson(user);
        break;
      case UserType.REGULAR:
        return RegularUser.fromJson(user);
        break;
      case UserType.ADMINISTRATOR:
        return AdminUser.fromJson(user);
        break;
      default:
        return null;
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }
//
//  Future<User> get(int id) async {
//    try {
//      final response = await _http.get('$_usersUrl/$id');
//
//      return fromJson(_extractData(response));
//    } catch (e) {
//      throw _handleError(e);
//    }
//  }

//  Future<User> create(String name) async {
//    try {
//      final response = await _http.post(_heroesUrl,
//          headers: _headers, body: json.encode({'name': name}));
//      return Hero.fromJson(_extractData(response));
//    } catch (e) {
//      throw _handleError(e);
//    }
//  }

  Future<User> update(User user) async {
    try {
      print('DEBUG: UPDATEEEEEEEEEEEe');
      final url = '$_usersUrl/${user.id}';
      final response =
          await _http.put(url, headers: _headers, body: json.encode(user));
      return UserService.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      final url = '$_usersUrl/$id';
      await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}
