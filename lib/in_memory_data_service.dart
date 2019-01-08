// Note: MockClient constructor API forces all InMemoryDataService members to
// be static.
import 'dart:async';
import 'dart:convert';

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
//    {
//      'id': '2',
//      'regDate': '2019-01-02 00:00:00',
//      'fullName': 'Crazy Frog',
//      'email': 'frog@gmail.com',
//      'userType': 'Regular',
//      'isAdmin': false
//    },
//    {
//      'id': '3',
//      'regDate': '2019-01-03 00:00:00',
//      'fullName': 'Harry Potter',
//      'email': 'harry@gmail.com',
//      'userType': 'Collaborator'
//    },
    {
      'id': '4',
      'regDate': '2019-01-04 00:00:00',
      'fullName': 'Devochka S Persikami',
      'email': 'devochka@gmail.com',
      'userType': 'Administrator',
      'isAdmin': true,
      'accessLevel': 'REDUCED'
    },
//    {
//      'id': '5',
//      'regDate': '2019-01-05 00:00:00',
//      'fullName': 'It',
//      'email': 'it@gmail.com',
//      'userType': 'Collaborator',
//    },
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
//    {'userId':'2','groupId':2,'isAdmin':false},
//    {'userId':'3','groupId':3,'isAdmin':false},
    {'userId':'4','groupId':4,'isAdmin':false},
  ];

  static List<Map<String, dynamic>> _usersDb;
  static int _nextUserId;

  static List<Map<String, dynamic>> _groupsDb;
  static int _nextGroupId;

  static List<Map<String, dynamic>> _relationDb;


  static Future<Response> _handler(Request request) async {
    if (_usersDb == null) _resetUserDb();
    if (_groupsDb == null) _resetGroupDb();
    if (_relationDb == null) _resetRelationUserGroupDb();
    var data;
    switch (request.method) {
      case 'GET':
        final url = request.url;
        if (url.path.indexOf('/users') >= 0) {
          if (url.pathSegments.last == 'users'){
            data = _usersDb;
          }
          if (request.url.queryParameters.isNotEmpty){
            String prefix;
            switch(request.url.queryParameters.keys.first){
              case 'idOrName':
                prefix = request.url.queryParameters['idOrName'] ?? '';
                final regExp = RegExp(prefix, caseSensitive: false);
                List<Map<String,dynamic>> users = List.from(_usersDb.where((user) => user['id'].contains(regExp) ||
                    user['fullName'].contains(regExp)).toList());
                users.forEach((user) {
                  user['userGroups'] = _getUserGroups(user);
                });
                data = users;
                break;
              case 'id':
                prefix = request.url.queryParameters['id'] ?? '';
                Map<String,dynamic> user = Map.from(_usersDb.firstWhere((user) => user['id'] == prefix));
                user['userGroups'] = _getUserGroups(user);
                data = user;
                break;
            }
          }
        }

        if (url.path.indexOf('/groups') >= 0) {
          if (url.pathSegments.last == 'groups'){
            data = _groupsDb;
          }
          if (request.url.queryParameters.isNotEmpty){
            String prefix;
            switch(request.url.queryParameters.keys.first){
              case 'idOrName':
                prefix = request.url.queryParameters['idOrName'] ?? '';
                final regExp = RegExp(prefix, caseSensitive: false);
                List<Map<String,dynamic>> groups = List.from(_groupsDb.where((group) => group['id'].toString().contains(regExp) ||
                    group['name'].contains(regExp)).toList());
                groups.forEach((group) {
                  var usersAndAdmins = _getGroupUsersAndAdmins(group);
                  group['users'] = usersAndAdmins['users'];
                  group['admins'] = usersAndAdmins['admins'];
                });
                data = groups;
                break;
              case 'id':
                prefix = request.url.queryParameters['id'] ?? '';
                Map<String,dynamic> group = Map.from(_groupsDb.firstWhere((group) => group['id'].toString() == prefix));
                var usersAndAdmins = _getGroupUsersAndAdmins(group);
                group['users'] = usersAndAdmins['users'];
                group['admins'] = usersAndAdmins['admins'];
                data = group;
                break;
            }
          }
        }

        break;
      case 'POST':
        final url = request.url;
        Map<String, dynamic> map = json.decode(request.body);
        if (url.path.indexOf('/users') >= 0) {
          map.addAll({'id': '$_nextUserId'});
          _nextUserId++;
          var newUser = map;
          _usersDb.add(newUser);
          data = newUser;
        }
        if (url.path.indexOf('/groups') >= 0) {
          map.addAll({'id': _nextGroupId});
          _nextGroupId++;
          var newGroup = map;
          _groupsDb.add(newGroup);
          data = newGroup;
        }
        if (url.path.indexOf('/relations') >= 0) {
          var newRelation = map;
          _relationDb.add(newRelation);
          data = newRelation;
        }
        break;
      case 'PUT':
        final url = request.url;
        if (url.path.indexOf('/users') >= 0) {
          var userChanges = json.decode(request.body);
          var targetUser = _usersDb.firstWhere((user) => user['id'] == userChanges['id']);
          _usersDb.remove(targetUser);
          _usersDb.add(userChanges);
          data = userChanges;
        }
        if (url.path.indexOf('/groups') >= 0) {
          var groupChanges = json.decode(request.body);
          var targetUser = _groupsDb.firstWhere((group) => group['id'] == groupChanges['id']);
          _groupsDb.remove(targetUser);
          _groupsDb.add(groupChanges);
          data = groupChanges;
        }
        break;
      case 'DELETE':
        final url = request.url;
        if (url.path.indexOf('/users') >= 0) {
          var id = request.url.pathSegments.last;
          _usersDb.removeWhere((user) => user['id'] == id);
          _relationDb.removeWhere((relation) => relation['userId'] == id);
        }
        if (url.path.indexOf('/groups') >= 0) {
          var id = request.url.pathSegments.last;
          _groupsDb.removeWhere((group) => group['id'] == id);
          _relationDb.removeWhere((relation) => relation['groupId'].toString() == id);
        }
        if (url.path.indexOf('/relations') >= 0) {
          var userId = request.url.queryParameters['userId'];
          var groupId = request.url.queryParameters['groupId'];
          _relationDb.removeWhere((relation) => relation['groupId'].toString() == groupId && relation['userId'] == userId);

        }
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return Response(json.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});
  }

  static _getUserGroups(Map<String, dynamic> user){
    List<Map<String,dynamic>> usersGroups = [];
    _relationDb.toList().forEach((relation){
      if (relation['userId'] == user['id']){
        usersGroups.add(_groupsDb.toList().firstWhere((group) => group['id'] == relation['groupId']));
      }
    });
    return usersGroups;
  }

  static _getGroupUsersAndAdmins(Map<String, dynamic> group){
    Map<String, List<Map<String,dynamic>>> usersAndAdmins = {};
    List<Map<String,dynamic>> groupUsers = [];
    List<Map<String,dynamic>> groupAdmins = [];
    _relationDb.toList().forEach((relation){
      if (relation['groupId'] == group['id']){
        var user = _usersDb.toList().firstWhere((user) => user['id'] == relation['userId']);
        groupUsers.add(user);
        if (relation['isAdmin']) groupAdmins.add(user);
      }
    });
    usersAndAdmins['users'] = groupUsers;
    usersAndAdmins['admins'] = groupAdmins;
    return usersAndAdmins;
  }

  static _resetUserDb() {
    _usersDb = _initialUsers.toList();
    _nextUserId = _usersDb.length + 1;
  }
  static _resetGroupDb() {
    _groupsDb = _initialGroups.toList();
    _nextGroupId = _groupsDb.length + 1;
  }

  static _resetRelationUserGroupDb() {
    _relationDb = _initialRelationsUserGroup..toList();
  }

  InMemoryDataService() : super(_handler);
}
