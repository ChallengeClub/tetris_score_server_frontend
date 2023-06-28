import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/training_form_model.dart';
import '../../view_model/providers.dart';

class TrainingListBlock extends ConsumerWidget {
  final String _section;
  TrainingListBlock(this._section);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TrainingModel> _trainings = ref.watch(trainingListStateNotifierProvider(_section));
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    double _line_height = _height*0.07;
    double _line_width = _width;
    return Container(
      height: _trainings.length*_line_height+10,
      child: ListView.builder(
        itemCount: _trainings.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => context.push('/training/${_section}/${_trainings[index].id}'),
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: _line_width*0.08),
            height: _line_height,
            child: Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(_trainings[index].section_id, style: TextStyle(fontSize: 10,)),
                    ),
                    SizedBox(height: 3),
                    Container(
                      padding: EdgeInsets.only(left: _line_width*0.05),
                      alignment: Alignment.bottomLeft,
                      child: Text(_trainings[index].title ?? "", style: TextStyle(fontSize: 12,), overflow: TextOverflow.ellipsis)
                    )
                  ]
                ),
                decoration: BoxDecoration(
                    border: Border(
                    bottom: BorderSide(
                        color: Colors.grey, //枠線の色
                        width: 0.5, //枠線の太さ
                    ),
                    ),
                ),
            )
            )
          );
        },
      )
    );
  }
}
