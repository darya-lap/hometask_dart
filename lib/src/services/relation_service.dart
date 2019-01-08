import 'dart:async';
import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/group_user_relation/group_user_relation.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/admin_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/collaborator_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/regular_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';
import 'package:http/http.dart';


class RelationService {
  static final _headers = {'Content-Type': 'application/json'};
  static const _relationUrl = 'api/relations';

  final Client _http;

  RelationService(this._http);

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }

  Future<GroupUserRelation> create(Map<String, dynamic> jsonMap) async {
    try {
      final response = await _http.post(_relationUrl,
          headers: _headers, body: json.encode(jsonMap));
      return GroupUserRelation.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(int groupId, String userId) async {
    try {
      final url = '$_relationUrl/?userId=$userId&groupId=$groupId';
      await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}
