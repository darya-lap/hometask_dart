import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/services/group_search_service.dart';
import 'package:stream_transform/stream_transform.dart';


@Component(
  selector: 'group-search',
  templateUrl: 'group_search_component.html',
  styleUrls: ['group_search_component.css'],
  directives: [coreDirectives],
  providers: [ClassProvider(GroupSearchService)],
  pipes: [commonPipes],
)
class GroupSearchComponent implements OnInit {
  final GroupSearchService _groupSearchService;
  final StreamController<String> _searchTerms = StreamController<String>.broadcast();
  final _toDescriptionStreamController= StreamController<Group>.broadcast();

  Stream<List<Group>> groups;

  @Output()
  Stream get goDescription => _toDescriptionStreamController.stream;

  GroupSearchComponent(this._groupSearchService);

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

  void gotoDetail(Group group) => _toDescriptionStreamController.add(group);
}
