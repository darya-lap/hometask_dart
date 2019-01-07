import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/access_level.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';

@Component(
  selector: 'add-user',
  templateUrl: 'add_user_component.html',
  styleUrls: ['add_user_component.css'],
  directives: [coreDirectives, formDirectives],
)
class AddUserComponent implements OnInit{

  final UserService _userService;
  final userTypes = UserType.values;
  final accessLevels = AccessLevel.values;
  final _addStreamController= StreamController<User>.broadcast();

  @Output()
  Stream get add => _addStreamController.stream;

  UserType currentSelectedUserType;
  AccessLevel currentSelectedAccessLevel;
  String currentFullName;
  String currentEmail;
  String currentRegDate;


  AddUserComponent(this._userService);

  Future<void> addUser() async {
    await _userService.create(toJson()).then((user) {_addStreamController.add(user);});
  }

  @override
  void ngOnInit() {
    currentSelectedUserType = UserType.ADMINISTRATOR;
    currentSelectedAccessLevel = AccessLevel.REDUCED;
    currentFullName = '';
    currentEmail = '';
    currentRegDate = DateTime.now().toString();
  }

  Map<String, dynamic> toJson() => {'regDate':currentRegDate, 'fullName':currentFullName, 'email':currentEmail,
  'isAdmin':false, 'userType':currentSelectedUserType.value, 'accessLevel':currentSelectedAccessLevel.value};
}
