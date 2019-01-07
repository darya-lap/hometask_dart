import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
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
class UserComponent{

  @Input()
  User user;

  final UserService _userService;
  final userTypes = UserType.values;
  final accessLevels = AccessLevel.values;
//
//  bool get isRegular => user.userType == UserType.REGULAR;
//  bool get isAdministrator => user.userType == UserType.ADMINISTRATOR;
//
//
//  bool get isAdminField => isRegular || isAdministrator;
//  bool get isAccessTypeField => isAdministrator;

//  bool get isAdmin {
//    if (isRegular) {
//      return (user as RegularUser).isAdmin;
//    } else if (isAdministrator) {
//      return (user as AdminUser).isAdmin;
//    }
//    return null;
//  }
//
//  set isAdmin(bool val){
//    if (isRegular) {
//      (user as RegularUser).isAdmin = val;
//    } else if (isAdministrator) {
//      (user as AdminUser).isAdmin = val;
//    }
//  }

//  String get accessType{
//    if(isAccessTypeField) return (user as AdminUser).accessLevel.value;
//    return null;
//  }
//  final Location _location;

  UserComponent(this._userService);

//  @override
//  void onActivate(_, RouterState current) async {
//    final id = getId(current.parameters);
//    if (id != null) hero = await (_heroService.get(id));
//  }

  Future<void> save() async {
    await _userService.update(user);
//    goBack();
  }

//  void goBack() => _location.back();

}
