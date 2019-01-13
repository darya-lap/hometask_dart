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
  final RelationService _relationService;
  final _changes= StreamController<Map<String,dynamic>>.broadcast();

  List<User> users;

  @Input()
  Group group;

  @Output()
  Stream get changesStream => _changes.stream;

  GroupUsersComponent(this._relationService);

  Future<void> delete(User user) async {
    await _relationService.delete(group.id, user.id).then((map) {
      _changes.add({'delete':map['userId']});
    });
    users.remove(user);
  }

  Future<void> makeAdmin(User user) async {
    await _relationService.update({'userId':user.id,'groupId':group.id,'isAdmin':true}).then((map) {
      _changes.add({'makeAdmin':user.id});
    });
  }

  bool isAdmin(User user){
    return group.admins.where((userMap) => userMap.id == user.id).isNotEmpty;
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    users = group.users;
  }
}