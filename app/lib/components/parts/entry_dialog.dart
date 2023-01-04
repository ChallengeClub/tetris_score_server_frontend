import 'package:flutter/material.dart';

import '../../model/entry_model.dart' as EntryModel;

Future<void> showEntryDialog(BuildContext context, EntryModel.EntryModel entry) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("name: ${entry.name}"),
              Text("url: ${entry.repository_url}"),
              Text("status: ${entry.status}"),
              Text("branch: ${entry.branch}"),
              Text("created at: ${EntryModel.datetimeToString(entry.created_at)}"),
              Text("level: ${entry.level.toString()}"),
              Text("game mode: ${entry.game_mode}"),
              Text("predict_weight_path: ${entry.predict_weight_path}"),
              Text("error message: ${entry.error_message}")
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