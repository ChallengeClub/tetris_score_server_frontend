import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../parts/server_button.dart';
import '../parts/competition_button.dart';


class HomeContentsField extends HookConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: _size.height*0.01, horizontal: _size.width*0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Contents", 
              style: TextStyle(fontSize: 20,),
            ),
            padding: EdgeInsets.only(bottom: _size.width*0.05)
          ),
          Container(
              height: 2*150,
              child: Column(
                children: [
                  ServerButton(),
                  CompetitionButton(),
                ]
              )
          )         
        ]
      )
    );
  }
}