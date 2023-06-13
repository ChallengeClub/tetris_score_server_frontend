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
      body: ((){
        if (_size.width < 700){
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                HomeNewsField(),
                HomeContentsField(),
              ],
            ),
          );
        }
        else {
          return Row(
            children: <Widget>[
              HomeNewsField(),
              HomeContentsField(),
            ],
          );
        }
      })(),
    );
  }
}
