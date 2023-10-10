import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/providers.dart';
import '../blocks/training_list_block.dart';
import '../blocks/custom_appbar.dart';
import '../blocks/user_menu_drawer.dart';

class TrainingListsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    double _line_height = _height*0.07;
    double _line_width = _width;
    return Scaffold(
      appBar: CustomAppbar(title: const Text('Tetris Training Page')),
      endDrawer: UserMenuDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: _height*0.02, horizontal: _width*0.05),
          width: _line_width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Trainings", 
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: EdgeInsets.only(bottom: _width*0.05)
              ),
              TrainingListBlock("algorithm"),
              TrainingListBlock("tetris"),              
              TrainingListBlock("turtle"),
            ]
          )
        )
      )
    );
  }
}
