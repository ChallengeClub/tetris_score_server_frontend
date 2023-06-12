import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'score_server_page.dart';
import 'competition_entry_page.dart';
import '../parts/server_button.dart';
import '../parts/competition_button.dart';
import '../blocks/home_news.dart';
import '../blocks/home_contents.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Tetris HP')),
      body: GridView.count(
        crossAxisCount: _size.width > 300 ? (_size.width/300).floor() : 1,
        children: <Widget>[
          HomeNewsField(),
          HomeContentsField(),
        ],
      )
      // body: Container(
      //   child: ListView(
      //     scrollDirection: Axis.horizontal,
      //     padding: const EdgeInsets.all(8),
      //     children: <Widget>[
      //       CompetitionButton(),
      //       ServerButton()
      //     ],
      //   ),
      // )
    );
  }
}
