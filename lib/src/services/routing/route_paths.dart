import 'package:angular_router/angular_router.dart';

const idUserParam = 'idUser';
const idGroupParam = 'idGroup';

class RoutePaths {
  static final users = RoutePath(path: 'users');
//  static final groups = RoutePath(path: 'groups');
//
//  static final user = RoutePath(path: '${users.path}/:$idUserParam');
//  static final group = RoutePath(path: '${groups.path}/:$idGroupParam');
}

//int getUserId(Map<String, String> parameters) {
//  final id = parameters[idUserParam];
//  return id == null ? null : int.tryParse(id);
//}
//
//int getGroupId(Map<String, String> parameters) {
//  final id = parameters[idUserParam];
//  return id == null ? null : int.tryParse(id);
//}
