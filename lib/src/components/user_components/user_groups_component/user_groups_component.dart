import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/group_description_component/group_component.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';

@Component(
  selector: 'user-groups',
  templateUrl: 'user_groups_component.html',
  styleUrls: ['user_groups_component.css'],
  directives: [coreDirectives,
    GroupComponent,
 ],
  pipes: [commonPipes],
)
class UserGroupsComponent implements OnChanges {

  List<Group> groups;
//  Group selected;

  @Input()
  User user;

  UserGroupsComponent();

  Future<void> delete(Group group) async {
//    await _groupService.delete(group.id);
//    groups.remove(group);
//    if (selected == group) selected = null;
  }

  void updateContent(Group group){
//    var changedGroup = groups.firstWhere((u) => u.id == group.id);
//    var i = groups.indexOf(changedGroup);
//    groups.replaceRange(i, i+1, [group]);
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) => groups = user.groups;
}