import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_tour_of_heroes/src/components/models/group/group.dart';
import 'package:angular_tour_of_heroes/src/components/models/user/user.dart';
import 'package:angular_tour_of_heroes/src/services/relation_service.dart';
import 'package:angular_tour_of_heroes/src/services/user_search_service.dart';
import 'package:stream_transform/stream_transform.dart';


@Component(
  selector: 'add-user-search',
  templateUrl: 'add_user_search_component.html',
  styleUrls: ['add_user_search_component.css'],
  directives: [coreDirectives],
  providers: [ClassProvider(UserSearchService)],
  pipes: [commonPipes],
)
class AddUserSearchComponent implements OnInit {
  UserSearchService _userSearchService;

  Stream<List<User>> users;
  StreamController<String> _searchTerms = StreamController<String>.broadcast();
  final RelationService _relationService;

  @Input()
  Group group;

  AddUserSearchComponent(this._userSearchService, this._relationService);

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

    print('DEBUG: ON ITIN');
    print('DEBUG: $users');
  }

  void addUser(User user) async{
    var userInList = group.users.where((userMap) => userMap.id == user.id);
    if (userInList.isNotEmpty) return;
    await _relationService.create(toJson(user.id));
    group.users.add(user);
  }

  Map<String, dynamic> toJson(String userId) => {'userId':userId, 'groupId':group.id, 'isAdmin':false};
}
