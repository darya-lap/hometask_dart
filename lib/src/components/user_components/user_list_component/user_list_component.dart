import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/user_components/add_user_component/add_user_component.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/components/user_components/user_description_component/user_component.dart';
import 'package:angular_tour_of_heroes/src/components/user_components/user_search_component/user_search_component.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';

@Component(
  selector: 'my-users',
  templateUrl: 'user_list_component.html',
  styleUrls: ['user_list_component.css'],
  directives: [coreDirectives,
    UserComponent,
    AddUserComponent,
    UserSearchComponent],
  pipes: [commonPipes],
)
class UserListComponent implements OnInit {
  final UserService _userService;

  List<User> users;
  User selected;
  bool _isAddNewActive = false;

  bool get isAddNewActive => _isAddNewActive;

  UserListComponent(this._userService);

  Future<void> _getUsers() async {
    users = await _userService.getAll();
  }

  Future<void> addUserToList(User user) async {
    users.add(user);
  }

  Future<void> delete(User user) async {
    await _userService.delete(user.id);
    users.remove(user);
    if (selected == user) selected = null;
  }

  void ngOnInit() => _getUsers();

  Future<void> onSelect(User user) async{
    await _userService.getUser(user.id).then((user) {selected = user;});
    _isAddNewActive = false;
  }

  void updateContent(User user){
    var changedUser = users.firstWhere((u) => u.id == user.id);
    var i = users.indexOf(changedUser);
    users.replaceRange(i, i+1, [user]);
  }

  activateAddNew(){
    _isAddNewActive = true;
  }

  void goToDescription(User user){
    _isAddNewActive = false;
    selected = user;
  }
}