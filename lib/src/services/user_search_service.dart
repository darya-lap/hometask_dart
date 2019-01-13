import 'dart:async';
import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';
import 'package:http/http.dart';

class UserSearchService {
  final Client _http;

  UserSearchService(this._http);

  Future<List<User>> search(String term) async {
    try {
      final response = await _http.get('app/users/?idOrName=$term');
      return (_extractData(response) as List)
          .map((json) => UserService.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e);
    return Exception('Server error; cause: $e');
  }
}
