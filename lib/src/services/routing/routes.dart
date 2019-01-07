import 'package:angular_router/angular_router.dart';

import 'package:angular_tour_of_heroes/src/services/routing/route_paths.dart';

//import 'package:angular_tour_of_heroes/src/components/group_list_component/group_list_component.template.dart' as group_list_template;

import 'package:angular_tour_of_heroes/src/components/user_list_component/user_list_component.template.dart' as user_list_template;

export 'package:angular_tour_of_heroes/src/services/routing/route_paths.dart';

class Routes {
  static final users = RouteDefinition(
    routePath: RoutePaths.users,
    component: user_list_template.UserListComponentNgFactory,
  );
//
//  static final user = RouteDefinition(
//    routePath: RoutePaths.user,
//    component: user_template.UserComponentNgFactory,
//  );

//  static final groups = RouteDefinition(
//    routePath: RoutePaths.groups,
//    component: group_list_template.GroupListComponentNgFactory,
//  );
//
//  static final group = RouteDefinition(
//    routePath: RoutePaths.group,
//    component: group_template.GroupComponentNgFactory,
//  );

  static final all = <RouteDefinition>[
    users,
   // user,
   // groups,
   // group,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.users.toUrl(),
    ),
  ];
}
