import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/result_model.dart';
import '../../view_model/providers.dart';

class ResultsTable extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ResultModel> _results = ref.watch(resultStateNotifierProvider);
    var _screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: FittedBox(
        child: (_screenSize.width <= 500) ? this.mapToDataTableForMobilePhone(_results) : this.mapToDataTable(_results)
      ));
  }

  DataTable mapToDataTableForMobilePhone(List<ResultModel> _results){
    const List<String> _columnList = [
        "created at",
        "status",
        "repository url"
    ];
    return DataTable(
      columns: _columnList.map((String column) => DataColumn(label: Text(column))).toList(),
      rows: _results.map((ResultModel result) => DataRow(
        cells: <DataCell>[
                DataCell(Text(DateTime.fromMillisecondsSinceEpoch(result.created_at).toString().substring(0, DateTime.fromMillisecondsSinceEpoch(result.created_at).toString().length-4))),
                DataCell(Text(result.status)),
                DataCell(Text(result.repository_url))
              ]
      )).toList()
    );
  }
  DataTable mapToDataTable(List<ResultModel> _results){
    const List<String> _columnList = [
        "created at",
        "status",
        "level",
        "repository url",
        "branch",
        "game mode",
        "game time",
        "trial number",
        "mean score"
    ];
    return DataTable(
      columns: _columnList.map((String column) => DataColumn(label: Text(column))).toList(),
      rows: _results.map((ResultModel result) => DataRow(
        cells: <DataCell>[
                DataCell(Text(DateTime.fromMillisecondsSinceEpoch(result.created_at).toString().substring(0, DateTime.fromMillisecondsSinceEpoch(result.created_at).toString().length-4))),
                DataCell(Text(result.status)),
                DataCell(Text(result.level.toString())),
                DataCell(Text(result.repository_url)),
                DataCell(Text(result.branch)),
                DataCell(Text(result.game_mode)),
                DataCell(Text(result.game_time.toString())),
                DataCell(Text(result.trial_number.toString())),
                DataCell(Text(result.mean_score.toString()))
              ]
      )).toList()
    );
  }
}