import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/group_description_component/group_component.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/components/user_components/add_group_search_component/add_group_search_component.dart';
import 'package:angular_tour_of_heroes/src/services/relation_service.dart';

@Component(
  selector: 'user-groups',
  templateUrl: 'user_groups_component.html',
  styleUrls: ['user_groups_component.css'],
  directives: [coreDirectives,
    GroupComponent,
    AddGroupSearchComponent
  ],
  providers: [RelationService,],
  pipes: [commonPipes],
)
class UserGroupsComponent implements OnChanges {
  final RelationService _relationService;

  List<Group> groups;

  @Input()
  User user;

  UserGroupsComponent(this._relationService);

  Future<void> delete(Group group) async {
    await _relationService.delete(group.id, user.id);
    groups.remove(group);
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) => groups = user.groups;
}