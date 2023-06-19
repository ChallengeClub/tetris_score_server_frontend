import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/entry_form.dart';
import '../blocks/entry_table.dart';
import '../blocks/entry_top.dart';
import '../../view_model/providers.dart';

class CompetitionEntryPage extends ConsumerWidget {
  final String _competition;
  CompetitionEntryPage(this._competition);
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Top'),
    Tab(text: 'Form'),
    Tab(text: 'Entries'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: tabs.length,
      child: SelectionArea(
        child: Scaffold(
        appBar: AppBar(
          title: Text("Entry Page for Tetris ${_competition}"),
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: _size.width > 700 ? _size.width*0.2 : _size.width*0.05), 
              child: EntryTop(),
            ),
            Center(
              child: Container(margin: const EdgeInsets.all(20), child: EntryForm(_competition)),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: (){
                            ref.read(entriesStateNotifierProvider.notifier).writeToFile();
                          },
                          child: const Text("Download")
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            ref.read(entriesStateNotifierProvider.notifier).fetchEntries();
                          },
                          child: const Text("Refresh")
                        )
                      ]
                    )
                  ),
                ),
                Expanded(
                  child: EntryStatusTable(),
                ),
              ]
            )
          ]
        )
        )
      )
    );
  }
}
