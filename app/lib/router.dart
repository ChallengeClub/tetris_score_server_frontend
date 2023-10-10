import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'components/pages/home_page.dart';
import 'components/pages/competition_entry_page.dart';
import 'components/pages/score_server_page.dart';
import 'components/pages/result_dialog_page.dart';
import 'components/pages/news_page.dart';
import 'components/pages/news_detail_page.dart';
import 'components/pages/training_page.dart';
import 'components/pages/turtle_training_page.dart';
import 'components/pages/training_lists_page.dart';
import 'components/pages/user_page.dart';

final GoRouter Router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'news',
          builder: (BuildContext context, GoRouterState state) {
            return NewsPage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: ':Id',
              builder: (BuildContext context, GoRouterState state) {
                return NewsDetailPage(state.params['Id'] ?? "");
              },
            ),
          ]
        ),
        GoRoute(
          path: 'entry/:Competition',
          builder: (BuildContext context, GoRouterState state) {
            String _competition = state.params['Competition'] ?? "";
            if (["v4", "v5"].contains(_competition)){
              return CompetitionEntryPage(_competition);
            } else {
              return Text("coming soon......");
            }
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
        GoRoute(
          path: 'users',
          builder: (BuildContext context, GoRouterState state) {
            return UserPage();
          },
        ),
        GoRoute(
          path: 'trainings',
          builder: (BuildContext context, GoRouterState state) {
            return TrainingListsPage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'algorithm/:Id',
              builder: (BuildContext context, GoRouterState state) {
                return TrainingPage("algorithm", state.params['Id'] ?? "");
              },
            ),      
            GoRoute(
              path: 'tetris/:Id',
              builder: (BuildContext context, GoRouterState state) {
                return TrainingPage("tetris", state.params['Id'] ?? "");
              },
            ),      
            GoRoute(
              path: 'turtle/:Id',
              builder: (BuildContext context, GoRouterState state) {
                return TurtleTrainingPage("turtle", state.params['Id'] ?? "");
              },
            ),
          ]
        ),
      ],
    ),
  ],
);