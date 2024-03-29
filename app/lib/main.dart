import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'router.dart' as Router;

Future main() async {
  setUrlStrategy(PathUrlStrategy()); 
  // パスベースのURLストラテジーを設定　これがないと、authのリダイレクト時にhttps://hogehoge/#/にリダイレクトされてしまって認可コードを取得できない
  runApp(
    ProviderScope(
      child: TetrisApp(),
    ),
  );
}

class TetrisApp extends ConsumerWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Tetris HP',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routerConfig: Router.Router,
    );
  }
}
