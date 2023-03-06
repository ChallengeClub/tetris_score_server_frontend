import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'components/pages/home_page.dart';
import 'components/pages/competition_entry_page.dart';
import 'components/pages/score_server_page.dart';
import 'components/blocks/result_dialog.dart';

final GoRouter Router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'entry',
          builder: (BuildContext context, GoRouterState state) {
            return CompetitionEntryPage();
          },
        ),
        GoRoute(
          path: 'server',
          builder: (BuildContext context, GoRouterState state) {
            return ScoreServerPage();
          },
          routes: <RouteBase> [
            GoRoute(
              path: 'results/:Id',
              builder: (BuildContext context, GoRouterState state) {
                  return ResultDetailView(state.params['Id'] ?? "");
              },
            )
          ]
        ),
      ],
    ),
  ],
);