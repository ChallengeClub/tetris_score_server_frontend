import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'components/pages/score_server_page.dart';
import 'components/pages/competition_entry_page.dart';
import 'components/parts/server_button.dart';
import 'components/parts/competition_button.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => EntryPage(),
        '/Server': (context) => ScoreServerPage(),
        '/Entry': (context) => CompetitionEntryPage()
      }
    );
  }
}

class EntryPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tetris HP')),
      body: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            CompetitionButton(),
            ServerButton()
          ],
        ),
      )
    );
  }
}
