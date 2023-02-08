import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../model/result_model.dart' as ResultModel;
import '../../view_model/providers.dart';
import '../parts/result_dialog.dart'as ResultDialog;

class ResultsTable extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ResultModel.ResultModel> _results = ref.watch(resultsStateNotifierProvider);
    ref.read(resultsStateNotifierProvider.notifier).sortResultsByCreatedAt();
    List<PlutoColumn> _columnList = this.getResultColumns();

    return (() {
          if (_results.length == 0) {
          // 初期化後、通信中
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return PlutoGrid(
                columns: _columnList,
                rows: _results.map((ResultModel.ResultModel _result) => PlutoRow(
                  cells: this.mapToDataCells(_result)
                )).toList(),
                rowColorCallback: (PlutoRowColorContext rowColorContext) {
                  String status = rowColorContext.row.cells['status']?.value;
                  Color color = Colors.white;
                  if (status=="succeeded"){
                    color = Color(0xFFE2F6DF);
                  } else if (status=="error"){
                    color = Color(0xFFFADBDF);
                  }
                  return color;
                }
          );
        }
        )();
  }
    
  List<PlutoColumn> getResultColumns(){
    List<PlutoColumn> res = [
      PlutoColumn(
        title: 'Created at',
        field: 'created_at',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Mean Score',
        field: 'mean_score',
        type: PlutoColumnType.number(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'URL',
        field: 'repository_url',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Branch',
        field: 'branch',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Game Time',
        field: 'game_time',
        type: PlutoColumnType.number(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Trials',
        field: 'trials',
        type: PlutoColumnType.number(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Level',
        field: 'level',
        type: PlutoColumnType.number(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'GameMode',
        field: 'game_mode',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Started at',
        field: 'started_at',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'Ended at',
        field: 'ended_at',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true,
      ),
      PlutoColumn(
        title: 'ErrorMessage',
        field: 'error_message',
        type: PlutoColumnType.text()
      ),
    ];
    return res;
  }

  Map<String, PlutoCell> mapToDataCells(ResultModel.ResultModel result){
    Map<String, PlutoCell> cells = {
      'created_at': PlutoCell(value: ResultModel.datetimeToString(result.created_at)),
      'name': PlutoCell(value: result.name),
      'mean_score': PlutoCell(value: result.mean_score),
      'level': PlutoCell(value: result.level),
      'repository_url': PlutoCell(value: result.repository_url),
      'branch': PlutoCell(value: result.branch),
      'game_time': PlutoCell(value: result.game_time),
      'trials': PlutoCell(value: result.trial_number),
      'status': PlutoCell(value: result.status),
      'started_at': PlutoCell(value: ResultModel.datetimeToString(result.started_at)),
      'ended_at': PlutoCell(value: ResultModel.datetimeToString(result.ended_at)),
      'game_mode': PlutoCell(value: result.game_mode),
      'error_message': PlutoCell(value: result.error_message),
    };
    return cells;
  }
}