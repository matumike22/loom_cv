import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'pages/add_cv_page.dart';
import 'pages/home_page.dart';
import 'widgets/dialog_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey, // root navigator for modals
    initialLocation: HomePage.routeName,
    routes: [
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: AddCvPage.routeName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return DialogPage(builder: (_) => AddCvPage());
            },
          ),
        ],
      ),
    ],
  );
});
