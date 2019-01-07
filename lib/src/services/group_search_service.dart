import 'dart:async';
import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:http/http.dart';


class GroupSearchService {
  final Client _http;

  GroupSearchService(this._http);

  Future<List<Group>> search(String term) async {
    try {
      final response = await _http.get('app/groups/?idOrName=$term');
      return (_extractData(response) as List)
          .map((json) => Group.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }
}
