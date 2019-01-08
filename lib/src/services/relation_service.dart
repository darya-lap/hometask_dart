import 'dart:async';
import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/user/admin_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/collaborator_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/regular_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';
import 'package:http/http.dart';


class RelationService {
  static final _headers = {'Content-Type': 'application/json'};
  static const _usersUrl = 'api/users'; // URL to web API
  static const _groupUrl = 'api/groups';

  final Client _http;

  RelationService(this._http);

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

  Future<User> create(Map<String, dynamic> jsonMap) async {
//    try {
//      final response = await _http.post(_usersUrl,
//          headers: _headers, body: json.encode(jsonMap));
//      return UserService.fromJson(_extractData(response));
//    } catch (e) {
//      throw _handleError(e);
//    }
  }

  Future<User> update(Map <String, dynamic> jsonMap) async {
//    try {
//      final url = '$_usersUrl/${jsonMap['id']}';
//      final response =
//      await _http.put(url, headers: _headers, body: json.encode(jsonMap));
//
//      return UserService.fromJson(_extractData(response));
//    } catch (e) {
//      throw _handleError(e);
//    }
  }

  Future<void> delete(String id) async {
    try {
      final url = '$_usersUrl/?$id';
      await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}