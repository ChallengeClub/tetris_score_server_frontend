import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/result_model.dart' as ResultModel;
import '../../view_model/providers.dart';
import '../parts/result_dialog.dart'as ResultDialog;

class ResultsTable extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ResultModel.ResultModel> _results = ref.watch(resultsStateNotifierProvider);
    ref.read(resultsStateNotifierProvider.notifier).sortResultsByCreatedAt();
    var _screenSize = MediaQuery.of(context).size;
    List<String> _columnList = this.getResultColumns(_screenSize.width);

    return SingleChildScrollView(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: DataTable(
          showCheckboxColumn: false,
          columns: _columnList.map((String column) => DataColumn(label: Text(column))).toList(),
          rows: _results.map((ResultModel.ResultModel result) => DataRow(
            onSelectChanged: (_) => ResultDialog.showResultDialog(context, result),
            cells: this.mapToDataCells(_screenSize.width, result)
          )).toList()
        )
      ));
  }
  List<String> getResultColumns(var width){
    List<String> res = [ // for mobile size
        "name",
        "created at",
        "status",
        "repository url"
      ];
    if (width >= 700){ // for desktop size
      res = [
        "name",
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
    }
    return res;
    }

  List<DataCell> mapToDataCells(var width, ResultModel.ResultModel result){
    List<DataCell> cells = [
        DataCell(Text(result.name)),
        DataCell(Text(ResultModel.datetimeToString(result.created_at))),
        DataCell(Text(result.status)),
        DataCell(Text(result.repository_url))
      ];
    if (width >= 700){ // for desktop size
      cells = [
        DataCell(Text(result.name)),
        DataCell(Text(ResultModel.datetimeToString(result.created_at))),
        DataCell(Text(result.status)),
        DataCell(Text(result.level.toString())),
        DataCell(Text(result.repository_url)),
        DataCell(Text(result.branch)),
        DataCell(Text(result.game_mode)),
        DataCell(Text(result.game_time.toString())),
        DataCell(Text(result.trial_number.toString())),
        DataCell(Text(result.mean_score.toString()))
      ];
    }
    return cells;
  }
}