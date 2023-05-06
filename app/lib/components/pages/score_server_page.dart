import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/form.dart';
import '../blocks/results_table.dart';
import '../parts/table_navigator.dart';
import '../../view_model/providers.dart';

class ScoreServerPage extends ConsumerWidget {
  final competition = "v4";
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Form'),
    Tab(text: 'Results'),
  ];
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: tabs.length,
      child: SelectionArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tetris Score Server"),
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(40), 
                  child: SubmitForm()
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TableNavigator(competition),
                  ),
                  Expanded(
                    child: ResultsTable(competition),
                  )
                ]
              )
            ],
          ),
        )
      )
    );
  }
}
