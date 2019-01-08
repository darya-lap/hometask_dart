import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/add_user_search_component/add_user_search_component.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/group_description_component/group_component.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/relation_service.dart';

@Component(
  selector: 'group-users',
  templateUrl: 'group_users_component.html',
  styleUrls: ['group_users_component.css'],
  directives: [coreDirectives,
    GroupComponent,
    AddUserSearchComponent
  ],
  providers: [RelationService,],
  pipes: [commonPipes],
)
class GroupUsersComponent implements OnChanges {

  List<User> users;

  final RelationService _relationService;

  @Input()
  Group group;

  GroupUsersComponent(this._relationService);

  Future<void> delete(User user) async {
    await _relationService.delete(group.id, user.id);
    users.remove(user);
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) => users = group.users;
}