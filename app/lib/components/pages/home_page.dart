import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'score_server_page.dart';
import 'competition_entry_page.dart';
import '../parts/server_button.dart';
import '../parts/competition_button.dart';
import '../blocks/home_news.dart';
import '../blocks/home_contents.dart';
import '../blocks/custom_appbar.dart';
import '../blocks/user_menu_drawer.dart';
import 'chat_room.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbar(title: Text('Tetris HP')),
      endDrawer: UserMenuDrawer(),
      body: ((){
        if (_size.width < 700){
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                HomeNewsField(_size.width, _size.height),
                HomeContentsField(_size.width, _size.height),
              ],
            ),
          );
        }
        else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeNewsField(_size.width/3, _size.height),
              HomeContentsField(_size.width*0.4, _size.height),
              const Expanded(
                child: ChatRoomField(),
              ),
            ],
          );
        }
      })(),
    );
  }
}
