import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/group_search_service.dart';
import 'package:angular_tour_of_heroes/src/services/relation_service.dart';
import 'package:stream_transform/stream_transform.dart';


@Component(
  selector: 'add-group-search',
  templateUrl: 'add_group_search_component.html',
  styleUrls: ['add_group_search_component.css'],
  directives: [coreDirectives],
  providers: [ClassProvider(GroupSearchService)],
  pipes: [commonPipes],
)
class AddGroupSearchComponent implements OnInit {
  GroupSearchService _groupSearchService;

  Stream<List<Group>> groups;
  StreamController<String> _searchTerms = StreamController<String>.broadcast();
  final RelationService _relationService;

  @Input()
  User user;

  AddGroupSearchComponent(this._groupSearchService, this._relationService);

  void search(String term) => _searchTerms.add(term);

  void ngOnInit() async {
    groups = _searchTerms.stream
        .transform(debounce(Duration(milliseconds: 300)))
        .distinct()
        .transform(switchMap((term) => term.isEmpty
            ? Stream<List<Group>>.fromIterable([<Group>[]])
            : _groupSearchService.search(term).asStream()))
        .handleError((e) {
      print(e); // for demo purposes only
    });
  }

  void addGroup(Group group) async{
    var groupInList = user.groups.where((groupMap) => groupMap.id == group.id);
    if (groupInList.isNotEmpty) return;
    await _relationService.create(toJson(group.id));
    user.groups.add(group);
  }

  Map<String, dynamic> toJson(int groupId) => {'userId':user.id, 'groupId':groupId, 'isAdmin':false};
}
