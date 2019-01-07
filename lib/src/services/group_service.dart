import 'dart:async';
import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:http/http.dart';


class GroupService {
  static final _headers = {'Content-Type': 'application/json'};
  static const _groupsUrl = 'api/groups'; // URL to web API

  final Client _http;

  GroupService(this._http);

  Future<List<Group>> getAll() async {
    try {
      final response = await _http.get(_groupsUrl);
      final groups = (_extractData(response) as List)
          .map((json) => Group.fromJson(json))
          .toList();
      return groups;
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }

  Future<Group> create(Map<String, dynamic> jsonMap) async {
    try {
      final response = await _http.post(_groupsUrl,
          headers: _headers, body: json.encode(jsonMap));
      return Group.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Group> update(Map <String, dynamic> jsonMap) async {
    try {
      final url = '$_groupsUrl/${jsonMap['id']}';
      final response =
      await _http.put(url, headers: _headers, body: json.encode(jsonMap));

      return Group.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      final url = '$_groupsUrl/$id';
      await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}
