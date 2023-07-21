import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'training_sample_field.dart';
import 'training_subhead.dart';

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
              TrainingSubhead(title),
              TrainingSampleField(sample, is_copy_enabled),
            ]
          )
        );
      }
    })();
  }
}

