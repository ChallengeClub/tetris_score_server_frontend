import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/result_model.dart' as ResultModel;
import '../../view_model/providers.dart';
import '../../view_model/interrupt_evaluation_view_model.dart' as InterruptButtonViewModel;

class EvaluationInterruptionButton extends ConsumerWidget {
  final ResultModel.ResultModel _result;
  EvaluationInterruptionButton(this._result);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _state = ref.watch(evaluationInterruptionStateNotifierProvider(_result));
    return  ((){
      if (_state is InterruptButtonViewModel.Enabled){
        return ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("評価を中断しますか？"),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        ref.read(evaluationInterruptionStateNotifierProvider.call(_result).notifier).requestInterruption();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Text("Stop"),
        );
      } else if (_state is InterruptButtonViewModel.Disabled){
        return ElevatedButton(
          onPressed: null,
          child: const Text("Stop"),
        );
      } else if (_state is InterruptButtonViewModel.Requesting){
        return CircularProgressIndicator();
      } else if (_state is InterruptButtonViewModel.Succeeded){
        return Text("interruption successfully requested");
      } else if (_state is InterruptButtonViewModel.Error){
        return Text(_state.message);
      } else {
        return Text("unexpected error occured\n${_state}");
      }
    })();
  }
}