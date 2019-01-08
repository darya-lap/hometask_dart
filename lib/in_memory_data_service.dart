// Note: MockClient constructor API forces all InMemoryDataService members to
// be static.
import 'dart:async';
import 'dart:convert';

import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/group_user_relation/group_user_relation.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';


class InMemoryDataService extends MockClient {
  static final _initialUsers = [
    {
      'id': '1',
      'regDate': '2019-01-01 00:00:00',
      'fullName': 'Princess Fiona',
      'email': 'fiona@gmail.com',
      'userType': 'Administrator',
      'isAdmin': true,
      'accessLevel': 'FULL'
    },
    {
      'id': '2',
      'regDate': '2019-01-02 00:00:00',
      'fullName': 'Crazy Frog',
      'email': 'frog@gmail.com',
      'userType': 'Regular',
      'isAdmin': false
    },
    {
      'id': '3',
      'regDate': '2019-01-03 00:00:00',
      'fullName': 'Harry Potter',
      'email': 'harry@gmail.com',
      'userType': 'Collaborator'
    },
    {
      'id': '4',
      'regDate': '2019-01-04 00:00:00',
      'fullName': 'Devochka S Persikami',
      'email': 'devochka@gmail.com',
      'userType': 'Administrator',
      'isAdmin': true,
      'accessLevel': 'REDUCED'
    },
    {
      'id': '5',
      'regDate': '2019-01-05 00:00:00',
      'fullName': 'It',
      'email': 'it@gmail.com',
      'userType': 'Collaborator',
    },
  ];

  static final _initialGroups = [
    {'id': 1, 'name': 'Princesses'},
    {'id': 2, 'name': 'Animals'},
    {'id': 3, 'name': 'Wizards'},
    {'id': 4, 'name': 'Girls'},
    {'id': 5, 'name': 'Loosers'}
  ];

  static final _initialRelationsUserGroup = [
    {'userId':'1','groupId':1,'isAdmin':false},
    {'userId':'1','groupId':4,'isAdmin':false},
    {'userId':'2','groupId':2,'isAdmin':false},
    {'userId':'3','groupId':3,'isAdmin':false},
    {'userId':'4','groupId':4,'isAdmin':false},
  ];

  static List<User> _usersDb;
  static int _nextUserId;

  static List<Group> _groupsDb;
  static int _nextGroupId;

  static List<GroupUserRelation> _relationUserGroupDb;

  static Future<Response> _handler(Request request) async {
    if (_usersDb == null) resetUserDb();
    if (_groupsDb == null) resetGroupDb();
    if (_relationUserGroupDb == null) resetRelationUserGroupDb();
    var data;
    var relations;
    switch (request.method) {
      case 'GET':
        final url = request.url;
        if (url.path.indexOf('/users') >= 0) {
          if (url.pathSegments.last == 'users'){
            data = _usersDb.where((user) => true).toList();
          }
          if (request.url.queryParameters.isNotEmpty){
            String prefix;
            switch(request.url.queryParameters.keys.first){
              case 'idOrName':
                prefix = request.url.queryParameters['idOrName'] ?? '';
                final regExp = RegExp(prefix, caseSensitive: false);
                data = _usersDb.where((user) => user.id.contains(regExp) ||
                    user.fullName.contains(regExp)).toList();
                break;
              case 'id':
                prefix = request.url.queryParameters['id'] ?? '';
                data = _usersDb.firstWhere((user) => user.id == prefix);
                break;
            }
          }
        }

        if (url.path.indexOf('/groups') >= 0) {
          if (url.pathSegments.last == 'groups'){
            data = _groupsDb.where((group) => true).toList();
          }
          if (request.url.queryParameters.isNotEmpty){
            String prefix;
            switch(request.url.queryParameters.keys.first){
              case 'idOrName':
                prefix = request.url.queryParameters['idOrName'] ?? '';
                final regExp = RegExp(prefix, caseSensitive: false);
                data = _groupsDb.where((group) => group.id.toString().contains(regExp) ||
                    group.name.contains(regExp)).toList();
                break;
              case 'id':
                prefix = request.url.queryParameters['id'] ?? '';
                data = _groupsDb.firstWhere((group) => group.id.toString() == prefix);
                break;
            }
          }
        }

        break;
      case 'POST':
        final url = request.url;
        Map<String, dynamic> map = json.decode(request.body);
        print(url.path);
        if (url.path.indexOf('/users') >= 0) {
          map.addAll({'id': '$_nextUserId'});
          _nextUserId++;
          var newUser = UserService.fromJson(map);
          _usersDb.add(newUser);
          data = newUser;
        }
        if (url.path.indexOf('/groups') >= 0) {
          map.addAll({'id': _nextGroupId});
          _nextGroupId++;
          var newGroup = Group.fromJson(map);
          _groupsDb.add(newGroup);
          data = newGroup;
        }
        break;
      case 'PUT':
        final url = request.url;
        if (url.path.indexOf('/users') >= 0) {
          var userChanges = UserService.fromJson(json.decode(request.body));
          var targetUser = _usersDb.firstWhere((h) => h.id == userChanges.id);
          _usersDb.remove(targetUser);
          _usersDb.add(userChanges);
          data = userChanges;
        }
        if (url.path.indexOf('/groups') >= 0) {
          var groupChanges = Group.fromJson(json.decode(request.body));
          var targetUser = _groupsDb.firstWhere((h) => h.id == groupChanges.id);
          _groupsDb.remove(targetUser);
          _groupsDb.add(groupChanges);
          data = groupChanges;
        }
        break;
      case 'DELETE':
        final url = request.url;
        if (url.path.indexOf('/users') >= 0) {
          var id = request.url.pathSegments.last;
          _usersDb.removeWhere((user) => user.id == id);
        }
        if (url.path.indexOf('/groups') >= 0) {
          var id = request.url.pathSegments.last;
          _groupsDb.removeWhere((group) => group.id.toString() == id);
        }
        // No data, so leave it as null.
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return Response(json.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});
  }

  static resetUserDb() {
    _usersDb = _initialUsers.map((json) => UserService.fromJson(json)).toList();
    _nextUserId = _usersDb.length + 1;
  }
  static resetGroupDb() {
    _groupsDb = _initialGroups.map((json) => Group.fromJson(json)).toList();
    _nextGroupId = _groupsDb.length + 1;
  }

  static resetRelationUserGroupDb() {
    _relationUserGroupDb = _initialRelationsUserGroup.map((json) {
      return GroupUserRelation.fromJson(json);
    }).toList();
  }

  InMemoryDataService() : super(_handler);
}
