import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_tour_of_heroes/src/services/group_service.dart';
import 'package:angular_tour_of_heroes/src/services/routing/routes.dart';
import 'package:angular_tour_of_heroes/src/services/user_service.dart';


@Component(
  selector: 'my-app',
  template: '''
    <h1>{{title}}</h1>
    <nav>
      <a [routerLink]="RoutePaths.users.toUrl()"
         [routerLinkActive]="'active'">Users</a>
      <a [routerLink]="RoutePaths.groups.toUrl()"
         [routerLinkActive]="'active'">Groups</a>
    </nav>
    <router-outlet [routes]="Routes.all"></router-outlet>
  ''',
  styleUrls: ['app_component.css'],
  directives: [routerDirectives],
  providers: [ClassProvider(UserService),
  ClassProvider(GroupService),
  ],
  exports: [RoutePaths, Routes],
)
class AppComponent {
  final title = 'Hometask Application';
}
