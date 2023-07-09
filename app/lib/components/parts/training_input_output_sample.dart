import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'training_sample_field.dart';

class TrainingInputOutputSample extends ConsumerWidget {
  final String title;
  final String? sample;
  final bool is_copy_enabled;
  TrainingInputOutputSample(this.title, this.sample, this.is_copy_enabled);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size _size = MediaQuery.of(context).size;

    return  ((){
      if (sample==null){
        return SizedBox(height:0);              
      } else {
        return Container(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(title, style: TextStyle(fontSize: 15)),
              ),
              TrainingSampleField(sample, is_copy_enabled),
            ]
          )
        );
      }
    })();
  }
}

