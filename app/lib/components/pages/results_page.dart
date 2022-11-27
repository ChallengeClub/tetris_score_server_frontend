import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers.dart';
import '../blocks/results_table.dart';

class ResultsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ElevatedButton(
              onPressed: (){
                ref.read(resultStateNotifierProvider.notifier).fetchResults();
                ref.read(resultStateNotifierProvider.notifier).sortResultsByCreatedAt();
              },
              child: const Text("Refresh")
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ResultsTable(),
          )
        ]
      )
    );
  }
}
