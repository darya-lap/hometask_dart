import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/add_group_component/add_group_component.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/group_description_component/group_component.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/group_search_component/group_search_component.dart';
//import 'package:angular_tour_of_heroes/src/components/group_components/add_group_component/add_group_component.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
//import 'package:angular_tour_of_heroes/src/components/group_components/group_description_component/group_component.dart';
//import 'package:angular_tour_of_heroes/src/components/group_components/group_search_component/group_search_component.dart';
import 'package:angular_tour_of_heroes/src/services/group_service.dart';

@Component(
  selector: 'my-groups',
  templateUrl: 'group_list_component.html',
  styleUrls: ['group_list_component.css'],
  directives: [coreDirectives,
    GroupComponent,
    AddGroupComponent,
    GroupSearchComponent
 ],
  pipes: [commonPipes],
)
class GroupListComponent implements OnInit {
  final GroupService _groupService;

  List<Group> groups;
  Group selected;
  bool _isAddNewActive = false;

  bool get isAddNewActive => _isAddNewActive;

  GroupListComponent(this._groupService);

  Future<void> _getGroups() async {
    groups = await _groupService.getAll();
  }

  Future<void> addGroupToList(Group group) async {
    groups.add(group);
  }

  Future<void> delete(Group group) async {
    await _groupService.delete(group.id);
    groups.remove(group);
    if (selected == group) selected = null;
  }

  void ngOnInit() => _getGroups();

  Future<void> onSelect(Group group) async{
    await _groupService.getGroup(group.id).then((group) {selected = group;});
    _isAddNewActive = false;
  }

  void updateContent(Group group){
    var changedGroup = groups.firstWhere((u) => u.id == group.id);
    var i = groups.indexOf(changedGroup);
    groups.replaceRange(i, i+1, [group]);
  }

  activateAddNew(){
    _isAddNewActive = true;
  }

  void goToDescription(Group group){
    _isAddNewActive = false;
    selected = group;
  }
}