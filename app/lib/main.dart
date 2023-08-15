import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'router.dart' as Router;
import 'view_model/providers.dart';

Future main() async {
  runApp(
    ProviderScope(
      child: TetrisApp(),
    ),
  );
}

class TetrisApp extends ConsumerWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userLoginStateNotifierProvider);
    return Authenticator(
      child: MaterialApp.router(
        title: 'Tetris HP',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        builder: Authenticator.builder(),
        routerConfig: Router.Router,
      )
    );
  }
}
