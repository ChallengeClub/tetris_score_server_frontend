import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'components/pages/form_page.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Form'),
    Tab(text: 'Results'),
  ];
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
        title: Text("Tetris評価サーバ"),
        bottom: TabBar(
          tabs: myTabs,
        ),
        ),
        body: TabBarView(
          children: [
            FormPage(),
            Text("results page")
          ],
        ),
      )
    )
    );
  }
}
