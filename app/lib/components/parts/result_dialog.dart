import 'package:flutter/material.dart';

import '../../model/result_model.dart' as ResultModel;

Future<void> showResultDialog(BuildContext context, ResultModel.ResultModel result) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("url: ${result.repository_url}"),
              Text("status: ${result.status}"),
              Text("branch: ${result.branch}"),
              Text("created at: ${ResultModel.datetimeToString(result.created_at)}"),
              Text("level: ${result.level.toString()}"),
              Text("number of trial: ${result.trial_number.toString()}"),
              Text("game mode: ${result.game_mode}"),
              Text("predict_weight_path: ${result.predict_weight_path}"),
              Text("mean_score: ${result.mean_score.toString()}"),
              Text("max_score: ${result.max_score.toString()}"),
              Text("max_score: ${result.min_score.toString()}"),
              Text("stddev_score: ${result.stddev_score.toString()}"),
              Text("error message: ${result.error_message}")
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}