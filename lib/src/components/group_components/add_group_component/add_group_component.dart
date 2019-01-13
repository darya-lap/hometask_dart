import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/services/group_service.dart';

@Component(
  selector: 'add-group',
  templateUrl: 'add_group_component.html',
  styleUrls: ['add_group_component.css'],
  directives: [coreDirectives, formDirectives],
)
class AddGroupComponent implements OnInit{
  final GroupService _groupService;
  final _addStreamController= StreamController<Group>.broadcast();

  String currentName;

  @Output()
  Stream get add => _addStreamController.stream;

  AddGroupComponent(this._groupService);

  Future<void> addGroup() async {
    await _groupService.create(toJson()).then((group) {_addStreamController.add(group);});
  }

  @override
  void ngOnInit(){
    currentName = '';
  }

  Map<String, dynamic> toJson() => {'name':currentName};
}
