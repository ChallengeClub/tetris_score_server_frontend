import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/form.dart';
import '../blocks/results_table.dart';
import '../parts/table_navigator.dart';
import '../../view_model/providers.dart';

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
          appBar: AppBar(
            title: Text("Tetris Score Server ${_competition}"),
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: _size.width > 700 ? _size.width*0.2 : _size.width*0.05), 
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: _size.height*0.1,
                        alignment: Alignment.center,
                        child: Text("Tetris Score Server", style: TextStyle(fontSize: 20)),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("概要", style: TextStyle(fontSize: 18)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: _size.width > 700 ? _size.width*0.05 : 20),
                              child: Text(
                              ''' 作成したテトリスプログラムをサーバ環境でテストし、開発したプログラムの動作確認とスコア評価をすることができます.''',
                              ),
                            )
                          ]
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("手順", style: TextStyle(fontSize: 18)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: _size.width > 700 ? _size.width*0.05 : 20),
                              height: 260,
                              child: ListView(
                                children: [
                                  ListTile(
                                    horizontalTitleGap: 5,
                                    leading: Text("1."),
                                    title: Text("Formタブに移動し、必要な入力項目を入力して画面下部のSubmitボタンを押してください。", style: TextStyle(fontSize: 12))
                                  ),
                                  ListTile(
                                    horizontalTitleGap: 5,
                                    leading: Text("2."),
                                    title: Text("Resultsタブに移動し、submitした評価リクエストが'waiting'状態で表示されたことを確認してください。", style: TextStyle(fontSize: 12))
                                  ),
                                  ListTile(
                                    horizontalTitleGap: 5,
                                    leading: Text("3."),
                                    title: Text("評価が開始するまでに最大5minかかります。評価が開始するとステータスが'evaluating'に更新されます。そのまま評価完了をお待ちください。", style: TextStyle(fontSize: 12))
                                  ),
                                  ListTile(
                                    horizontalTitleGap: 5,
                                    leading: Text("4."),
                                    title: Text("評価リクエスト発行後に評価を中断させたい場合には、中断させたい評価をクリックして評価詳細画面に移動し、stopボタンを押してください。", style: TextStyle(fontSize: 12))
                                  ),
                                ]
                              )
                            )
                          ]
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("必要事項", style: TextStyle(fontSize: 18)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: _size.width > 700 ? _size.width*0.05 : 20),
                              height: 250,
                              child: ListView(
                                children: [
                                  ListTile(
                                    title: Text("マスターリポジトリであるhttps://github.com/seigot/tetris.git をフォークして作成されたリポジトリであること。", style: TextStyle(fontSize: 12))
                                  ),
                                  ListTile(
                                    title: Text("リポジトリのルートディレクトリにおいて`python start.py`を実行することでスタート可能であること。", style: TextStyle(fontSize: 12))
                                  ),
                                ]
                              )
                            )
                          ]
                        )
                      ),
                    ]
                  ),
                ),
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
