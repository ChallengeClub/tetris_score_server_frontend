import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/result_model.dart';
import '../../view_model/providers.dart';

class ResultsTable extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ResultModel> _results = ref.watch(resultStateNotifierProvider.notifier).state;
    final List<String> _columnList = getResultColumns();

    return SingleChildScrollView(
      child: DataTable(
        columns: _columnList.map((String column) => DataColumn(label: Text(column))).toList(),
        rows: _results.map((ResultModel result) => DataRow(
          cells: <DataCell>[
            DataCell(Text(DateTime.fromMillisecondsSinceEpoch(result.created_at).toString())),
            DataCell(Text(result.status)),
            DataCell(Text(result.repository_url)),
            DataCell(Text(result.branch)),
            DataCell(Text(result.mean_score.toString()))
          ]
        )).toList()
      ));
  }
}