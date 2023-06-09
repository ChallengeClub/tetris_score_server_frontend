import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'components/pages/home_page.dart';
import 'components/pages/competition_entry_page.dart';
import 'components/pages/score_server_page.dart';
import 'components/pages/result_dialog_page.dart';

final GoRouter Router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'entry/:Competition',
          builder: (BuildContext context, GoRouterState state) {
            String _competition = state.params['Competition'] ?? "";
            if (["v4", "v5"].contains(_competition)){
              return ScoreServerPage(_competition);
            } else {
              return Text("coming soon......");
            } 
            return CompetitionEntryPage(_competition);
          },
        ),
        GoRoute(
          path: 'server/:Competition',
          builder: (BuildContext context, GoRouterState state) {
            String _competition = state.params['Competition'] ?? "";
            if (["v4", "v5"].contains(_competition)){
              return ScoreServerPage(_competition);
            } else {
              return Text("coming soon......");
            }          
          },
        ),
        GoRoute(
          path: 'results/:Id',
          builder: (BuildContext context, GoRouterState state) {
            return ResultDetailPage(state.params['Id'] ?? "");
          },
        ),
      ],
    ),
  ],
);