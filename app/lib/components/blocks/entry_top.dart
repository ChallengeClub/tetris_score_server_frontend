import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class EntryTop extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
            children: [
                Container(
                height: _size.height*0.1,
                alignment: Alignment.center,
                child: Text("Competition Entry", style: TextStyle(fontSize: 20)),
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
                        '''大会にエントリーすることができます。また、事前動作確認の結果を参照することもできます。''',
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
                        height: 200,
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
                            title: Text("Entriesタブに移動し、submitしたリクエストが'waiting'状態で表示されたことを確認してください。", style: TextStyle(fontSize: 12))
                            ),
                            ListTile(
                            horizontalTitleGap: 5,
                            leading: Text("3."),
                            title: Text("事前動作確認（大会本番数日前に実施）が実施された際にはステータスが更新されます", style: TextStyle(fontSize: 12))
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
                    Text("確認事項", style: TextStyle(fontSize: 18)),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: _size.width > 700 ? _size.width*0.05 : 20),
                        height: 150,
                        child: ListView(
                        children: [
                            ListTile(
                            title: Text("エントリーしたブランチのうち常に最新のコミットを参照するため、複数のエントリーをする際にはそれぞれ別のブランチを準備してください。", style: TextStyle(fontSize: 12))
                            ),
                            ListTile(
                            title: Text("リポジトリURLとレベルがいずれも過去のエントリーと同一であった場合には、エントリー情報は上書きされwaiting状態に戻ります。", style: TextStyle(fontSize: 12))
                            ),
                        ]
                        )
                    )
                    ]
                )
                ),
            ]
        ),
    );
  }
}
