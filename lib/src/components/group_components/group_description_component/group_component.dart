import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/group_users_component/group_users_component.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/group_service.dart';
import 'package:angular_tour_of_heroes/src/services/relation_service.dart';

@Component(
  selector: 'group-desc',
  templateUrl: 'group_component.html',
  styleUrls: ['group_component.css'],
  directives: [coreDirectives,
    formDirectives,
    GroupUsersComponent
  ],
)
class GroupComponent implements OnChanges{

  GroupService _groupService;
  RelationService _relationService;

  @Input()
  Group group;

  final _save= StreamController<Group>.broadcast();

  @Output()
  Stream get save => _save.stream;

  String currentName;
  List<User> admins;

  GroupComponent(this._groupService, this._relationService);

  Future<void> saveChanges() async {
    await _groupService.update(toJson()).then((group) {_save.add(group);});
  }

  Future<void> delete(User admin) async {
    await _relationService.update({'userId':admin.id,'groupId':group.id,'isAdmin':false});
    admins.remove(admin);
  }

  void changeUserList(Map<String,dynamic> map){
    if (map['delete'] != null) deleteUser(map['delete']);
    if (map['makeAdmin'] != null) updateAdminList(map['makeAdmin']);
  }

  void deleteUser(String userId){
    admins.removeWhere((admin) => admin.id == userId);
  }

  void updateAdminList(String userId){
    admins.add(group.users.firstWhere((user) => user.id == userId));
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    currentName = group.name;
    admins = group.admins;
  }

  Map<String, dynamic> toJson() => {'id':group.id, 'name':currentName};
}
