import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';

class HomeTutrialField extends HookConsumerWidget{
  double _width;
  double _height;
  HomeTutrialField(this._width, this._height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _height*0.02, horizontal: _width*0.05),
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Tutrials", 
              style: TextStyle(fontSize: 20,),
            ),
            padding: EdgeInsets.only(bottom: _width*0.05)
          ),  
          Text("under construction,,,"),
        ]
      )
    );
  }
}