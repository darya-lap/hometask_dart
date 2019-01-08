import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/admin_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/regular_user.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/enums/access_level.dart';
import 'package:angular_tour_of_heroes/src/enums/user_type.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';

@Component(
  selector: 'user-desc',
  templateUrl: 'user_component.html',
  styleUrls: ['user_component.css'],
  directives: [coreDirectives, formDirectives],
)
class UserComponent implements OnChanges{

  @Input()
  User user;

  final UserService _userService;
  final userTypes = UserType.values;
  final accessLevels = AccessLevel.values;
  final _save= StreamController<User>.broadcast();

  @Output()
  Stream get save => _save.stream;

  bool get isRegular => user.userType == UserType.REGULAR;
  bool get isAdministrator => user.userType == UserType.ADMINISTRATOR;

  UserType currentSelectedUserType;
  AccessLevel currentSelectedAccessLevel;
  String currentFullName;
  String currentEmail;
  String currentRegDate;

  bool get isAdmin {
    if (isRegular) {
      return (user as RegularUser).isAdmin;
    } else if (isAdministrator) {
      return (user as AdminUser).isAdmin;
    }
    return false;
  }

  String get accessLevel{
    if(isAdministrator) return (user as AdminUser).accessLevel.value;
    return null;
  }

  set accessLevel(String type){
    (user as AdminUser).accessLevel = AccessLevel.parse(type);
  }

  UserComponent(this._userService);

  Future<void> saveChanges() async {
    await _userService.update(toJson()).then((user) {_save.add(user);});
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    currentSelectedUserType = user.userType;
    if (currentSelectedUserType == UserType.ADMINISTRATOR) currentSelectedAccessLevel = (user as AdminUser).accessLevel;
    else currentSelectedAccessLevel = AccessLevel.REDUCED;
    currentFullName = user.fullName;
    currentEmail = user.email;
    currentRegDate = user.regDate.toString();
  }

  Map<String, dynamic> toJson() => {'id':user.id, 'regDate':currentRegDate, 'fullName':currentFullName, 'email':currentEmail,
  'isAdmin':isAdmin, 'userType':currentSelectedUserType.value, 'accessLevel':currentSelectedAccessLevel.value};
}