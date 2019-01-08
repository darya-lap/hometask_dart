import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_tour_of_heroes/src/components/group_components/group_users_component/group_users_component.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/services/group_service.dart';

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

  @Input()
  Group group;

  final _save= StreamController<Group>.broadcast();

  @Output()
  Stream get save => _save.stream;

  String currentName;

  GroupComponent(this._groupService);

  Future<void> saveChanges() async {
    await _groupService.update(toJson()).then((group) {_save.add(group);});
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    currentName = group.name;
  }

  Map<String, dynamic> toJson() => {'id':group.id, 'name':currentName};
}
