import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/entry_form.dart';
import '../blocks/entry_table.dart';
import '../../view_model/providers.dart';

class CompetitionEntryPage extends ConsumerWidget {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Form'),
    Tab(text: 'Entries'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Entry Page for Tetris v4"),
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Container(margin: const EdgeInsets.all(40), child: EntryForm()),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: (){
                          ref.read(entryTableStateNotifierProvider.notifier).writeToFile();
                        },
                        child: const Text("Download")
                      ),
                      ElevatedButton(
                        onPressed: (){
                          ref.read(entryTableStateNotifierProvider.notifier).fetchEntries();
                          print("button pressed");
                        },
                        child: const Text("Refresh")
                      )
                    ]
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: EntryStatusTable(),
                )
              ]
            )
          ]
        )
      )
    );
  }
}