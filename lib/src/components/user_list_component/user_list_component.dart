import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/components/user_component/user_component.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';

@Component(
  selector: 'my-users',
  templateUrl: 'user_list_component.html',
  styleUrls: ['user_list_component.css'],
  directives: [coreDirectives, UserComponent],
  pipes: [commonPipes],
)
class UserListComponent implements OnInit {
  final UserService _userService;

  final Router _router;
  List<User> users;
  User selected;

  UserListComponent(this._userService, this._router);

  Future<void> _getUsers() async {
    users = await _userService.getAll();
  }

//  Future<void> add(String name) async {
//    name = name.trim();
//    if (name.isEmpty) return null;
//    heroes.add(await _heroService.create(name));
//    selected = null;
//  }

  Future<void> delete(User user) async {
    await _userService.delete(user.id);
    users.remove(user);
    if (selected == user) selected = null;
  }

  void ngOnInit() => _getUsers();

  void onSelect(User user) => selected = user;

//  String _heroUrl(int id) =>
//      RoutePaths.user.toUrl(parameters: {idUserParam: '$id'});

//  Future<NavigationResult> gotoDetail() =>
//      _router.navigate(_heroUrl(selected.id));
}




//import 'dart:async';
//
//import 'package:angular/angular.dart';
//import 'package:angular_router/angular_router.dart';
//
//import 'route_paths.dart';
//import 'hero.dart';
//import 'hero_component.dart';
//import 'hero_service.dart';
//
//@Component(
//  selector: 'my-heroes',
//  templateUrl: 'hero_list_component.html',
//  styleUrls: ['hero_list_component.css'],
//  directives: [coreDirectives, HeroComponent],
//  pipes: [commonPipes],
//)
//class HeroListComponent implements OnInit {
//  final HeroService _heroService;
//  final Router _router;
//  List<Hero> heroes;
//  Hero selected;
//
//  HeroListComponent(this._heroService, this._router);
//
//  Future<void> _getHeroes() async {
//    heroes = await _heroService.getAll();
//  }
//
//  Future<void> add(String name) async {
//    name = name.trim();
//    if (name.isEmpty) return null;
//    heroes.add(await _heroService.create(name));
//    selected = null;
//  }
//
//  Future<void> delete(Hero hero) async {
//    await _heroService.delete(hero.id);
//    heroes.remove(hero);
//    if (selected == hero) selected = null;
//  }
//
//  void ngOnInit() => _getHeroes();
//
//  void onSelect(Hero hero) => selected = hero;
//
//  String _heroUrl(int id) =>
//      RoutePaths.hero.toUrl(parameters: {idParam: '$id'});
//
//  Future<NavigationResult> gotoDetail() =>
//      _router.navigate(_heroUrl(selected.id));
//}
