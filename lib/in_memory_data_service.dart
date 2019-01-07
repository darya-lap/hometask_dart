// Note: MockClient constructor API forces all InMemoryDataService members to
// be static.
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'src/hero.dart';

class InMemoryDataService extends MockClient {
  static final _initialUsers = [
    {'id': '1', 'regDate': '2019-01-01 00:00:00', 'fullName':'Princess Fiona', 'email':'fiona@gmail.com', 'userType':'Administrator', 'isAdmin':true, 'accessLevel':'FULL'},
    {'id': '2', 'regDate': '2019-01-02 00:00:00', 'fullName':'Crazy Frog', 'email':'frog@gmail.com', 'userType':'Regular', 'isAdmin':false},
    {'id': '3', 'regDate': '2019-01-03 00:00:00', 'fullName':'Harry Potter', 'email':'harry@gmail.com', 'userType':'Collaborator'},

  ];
  static List<User> _usersDb;
  static int _nextUserId;

  static Future<Response> _handler(Request request) async {
    if (_usersDb == null) resetDb();
    var data;
    switch (request.method) {
      case 'GET':
//        final id = int.tryParse(request.url.pathSegments.last);
//        if (id != null) {
//          data = _usersDb
//              .firstWhere((user) => user.id == id); // throws if no match
//        } else {
//          String prefix = request.url.queryParameters['name'] ?? '';
//          final regExp = RegExp(prefix, caseSensitive: false);
//          data = _usersDb.where((user) => user.name.contains(regExp)).toList();
//        }

        final url = request.url;
        if (url.pathSegments.last == 'users'){
          data = _usersDb.where((user) => true).toList();
        }
        break;
//      case 'POST':
//        var name = json.decode(request.body)['name'];
//        var newHero = Hero(_nextUserId++, name);
//        _usersDb.add(newHero);
//        data = newHero;
//        break;
      case 'PUT':
        final url = request.url;
        if (url.path.indexOf('/users/') >= 0){
          print('DEBUG: HELLO');
          var userChanges = UserService.fromJson(json.decode(request.body));
          var targetUser = _usersDb.firstWhere((h) => h.id == userChanges.id);
          targetUser = userChanges;
          data = targetUser;
        }


        break;
      case 'DELETE':
        final url = request.url;
        if (url.path.indexOf('/users/') >= 0){
          var id = request.url.pathSegments.last;
          _usersDb.removeWhere((hero) => hero.id == id);
        }
        // No data, so leave it as null.
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return Response(json.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});
  }

  static resetDb() {
    _usersDb = _initialUsers.map((json) => UserService.fromJson(json)).toList();
   // _nextUserId = _usersDb.map((hero) => hero.id).fold(0, max) + 1;
  }

//  static String lookUpName(int id) =>
//      _usersDb
//          .firstWhere((hero) => hero.id == id, orElse: null)
//          ?.name;

  InMemoryDataService() : super(_handler);
}
//}class InMemoryDataService extends MockClient {
//  static final _initialHeroes = [
//    {'id': 11, 'name': 'Mr. Nice'},
//    {'id': 12, 'name': 'Narco'},
//    {'id': 13, 'name': 'Bombasto'},
//    {'id': 14, 'name': 'Celeritas'},
//    {'id': 15, 'name': 'Magneta'},
//    {'id': 16, 'name': 'RubberMan'},
//    {'id': 17, 'name': 'Dynama'},
//    {'id': 18, 'name': 'Dr IQ'},
//    {'id': 19, 'name': 'Magma'},
//    {'id': 20, 'name': 'Tornado'}
//  ];
//  static List<Hero> _heroesDb;
//  static int _nextId;
//
//  static Future<Response> _handler(Request request) async {
//    if (_heroesDb == null) resetDb();
//    var data;
//    switch (request.method) {
//      case 'GET':
//        final id = int.tryParse(request.url.pathSegments.last);
//        if (id != null) {
//          data = _heroesDb
//              .firstWhere((hero) => hero.id == id); // throws if no match
//        } else {
//          String prefix = request.url.queryParameters['name'] ?? '';
//          final regExp = RegExp(prefix, caseSensitive: false);
//          data = _heroesDb.where((hero) => hero.name.contains(regExp)).toList();
//        }
//        break;
//      case 'POST':
//        var name = json.decode(request.body)['name'];
//        var newHero = Hero(_nextId++, name);
//        _heroesDb.add(newHero);
//        data = newHero;
//        break;
//      case 'PUT':
//        var heroChanges = Hero.fromJson(json.decode(request.body));
//        var targetHero = _heroesDb.firstWhere((h) => h.id == heroChanges.id);
//        targetHero.name = heroChanges.name;
//        data = targetHero;
//        break;
//      case 'DELETE':
//        var id = int.parse(request.url.pathSegments.last);
//        _heroesDb.removeWhere((hero) => hero.id == id);
//        // No data, so leave it as null.
//        break;
//      default:
//        throw 'Unimplemented HTTP method ${request.method}';
//    }
//    return Response(json.encode({'data': data}), 200,
//        headers: {'content-type': 'application/json'});
//  }
//
//  static resetDb() {
//    _heroesDb = _initialHeroes.map((json) => Hero.fromJson(json)).toList();
//    _nextId = _heroesDb.map((hero) => hero.id).fold(0, max) + 1;
//  }
//
//  static String lookUpName(int id) =>
//      _heroesDb.firstWhere((hero) => hero.id == id, orElse: null)?.name;
//
//  InMemoryDataService() : super(_handler);
//}
