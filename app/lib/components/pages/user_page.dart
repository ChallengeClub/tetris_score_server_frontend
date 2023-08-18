import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../view_model/providers.dart';
import '../blocks/custom_appbar.dart';
import '../blocks/user_menu_drawer.dart';

class UserPage extends HookConsumerWidget {
  UserPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? _user = ref.watch(userLoginStateNotifierProvider);
    Size _size = MediaQuery.of(context).size;

    return SelectionArea(
      child: Scaffold(
        appBar: CustomAppbar(title: const Text('Tetris HP')),
        endDrawer: UserMenuDrawer(),
        body: Center(
          child: (() {
            if (_user == null) {
            // 初期化後、通信中
              return CircularProgressIndicator.adaptive();
            } 
            return Container(
              width: _size.width > 700 ? 700 : _size.width,
              padding: EdgeInsets.symmetric(vertical: _size.height*0.05, horizontal: _size.width*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_user.name, style: TextStyle(fontSize: 20),),
                  SizedBox(height: _size.height*0.02),
                  Text("this page is under construction", style: TextStyle(fontSize: 12),),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: const Text('close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              )
            );
          }
        )(),
        )
      )
    );
  }
}

