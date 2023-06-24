import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';


import '../../model/training_form_model.dart';
import '../../view_model/training_form_view_model.dart';
import '../../view_model/providers.dart';

class TrainingPage extends HookConsumerWidget {
  final String _section;
  final String _id;
  TrainingPage(this._section, this._id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TrainingModel _training = TrainingModel(_section, _id, "", "");
    TrainingFormState _state = ref.watch(trainingFormStateNotifierProvider(_training));
    Size _size = MediaQuery.of(context).size;

    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Tetris Training Page')),
        body: Center(
          child: Container(
            width: _size.width > 700 ? 700 : _size.width,
            padding: EdgeInsets.symmetric(vertical: _size.height*0.05, horizontal: _size.width*0.05),
            child: Text("training"),
          )
        )
      )
    );
  }
}

