import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/form.dart';
import '../blocks/results_table.dart';
import '../blocks/score_server_top.dart';
import '../parts/table_navigator.dart';
import '../../view_model/providers.dart';
import '../blocks/custom_appbar.dart';
import '../blocks/user_menu_drawer.dart';

class ScoreServerPage extends ConsumerWidget {
  final String _competition;
  ScoreServerPage(this._competition);
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Top'),
    Tab(text: 'Form'),
    Tab(text: 'Results'),
  ];
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: tabs.length,
      child: SelectionArea(
        child: Scaffold(
          appBar: CustomAppbar(
            title: Text("Tetris Score Server ${_competition}"),
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          endDrawer: UserMenuDrawer(),
          body: TabBarView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: _size.width > 700 ? _size.width*0.2 : _size.width*0.05), 
                child: ScoreServerTop(),
              ),              
              Container(
                margin: const EdgeInsets.symmetric(vertical:10, horizontal: 40), 
                child: SubmitForm(_competition)
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TableNavigator(_competition),
                  ),
                  Expanded(
                    child: ResultsTable(_competition),
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
