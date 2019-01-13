import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/user_search_service.dart';
import 'package:stream_transform/stream_transform.dart';


@Component(
  selector: 'user-search',
  templateUrl: 'user_search_component.html',
  styleUrls: ['user_search_component.css'],
  directives: [coreDirectives],
  providers: [ClassProvider(UserSearchService)],
  pipes: [commonPipes],
)
class UserSearchComponent implements OnInit {
  UserSearchService _userSearchService;
  final _searchTerms = StreamController<String>.broadcast();
  final _toDescriptionStreamController= StreamController<User>.broadcast();

  Stream<List<User>> users;

  @Output()
  Stream get goDescription => _toDescriptionStreamController.stream;

  UserSearchComponent(this._userSearchService);

  void search(String term) => _searchTerms.add(term);

  void ngOnInit() async {
    users = _searchTerms.stream
        .transform(debounce(Duration(milliseconds: 300)))
        .distinct()
        .transform(switchMap((term) => term.isEmpty
            ? Stream<List<User>>.fromIterable([<User>[]])
            : _userSearchService.search(term).asStream()))
        .handleError((e) {
      print(e);
    });
  }

  void gotoDetail(User user) => _toDescriptionStreamController.add(user);
}
