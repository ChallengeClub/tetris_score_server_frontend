import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:go_router/go_router.dart';

import '../../model/result_model.dart' as ResultModel;
import '../../model/results_table_model.dart' as ResultsTableModel;
import '../../view_model/providers.dart';

class ResultsTable extends HookConsumerWidget{
  PlutoGridStateManager? stateManager;
  final String _competition;
  ResultsTable(this._competition);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultsTableModel.ResultsTableModel _results_table = ref.watch(resultsTableStateNotifierProvider(_competition));

    return (() {
      if (_results_table.results.length == 0) {
      // 初期化後、通信中
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }
      return PlutoGrid(
        mode: PlutoGridMode.selectWithOneTap,// select row with one tap and call onSelect callback
        columns: this.getResultColumns(),
        rows: _results_table.results.map((ResultModel.ResultModel _result) => PlutoRow(
          cells: this.mapToDataCells(_result)
        )).toList(),
        onLoaded: (PlutoGridOnLoadedEvent event) {
          event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
          stateManager = event.stateManager; // set stateManager instance when onLoaded
        },
        onSelected: (PlutoGridOnSelectedEvent event){
          dynamic _selectedResultId = stateManager!.currentRow!.cells["id"]!.value;
          context.push('/results/${_selectedResultId}');
        },
        rowColorCallback: (PlutoRowColorContext rowColorContext) {
          String status = rowColorContext.row.cells['status']?.value;
          Color color = Colors.white;
          if (status=="succeeded"){
            color = Color(0xFFE2F6DF);
          } else if (status=="error"){
            color = Color(0xFFFADBDF);
          } else if (status=="evaluating"){
            color = Color(0xE6FFF7DF);
          }
          return color;
        },
      );
    }
    )();
  }
    
  List<PlutoColumn> getResultColumns(){
    List<PlutoColumn> res = [
      PlutoColumn(
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.text(),
        hide: true, // hidden id column for select and filter the row 
      ),
      PlutoColumn(
        title: 'Created at',
        field: 'created_at',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Mean Score',
        field: 'mean_score',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'URL',
        field: 'repository_url',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Branch',
        field: 'branch',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Game Time',
        field: 'game_time',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Trials',
        field: 'trials',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Level',
        field: 'level',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'GameMode',
        field: 'game_mode',
        type: PlutoColumnType.text(),
      ),
    ];
    return res;
  }

  Map<String, PlutoCell> mapToDataCells(ResultModel.ResultModel result){
    Map<String, PlutoCell> cells = {
      'id': PlutoCell(value: result.id),
      'created_at': PlutoCell(value: ResultModel.datetimeToString(result.created_at)),
      'name': PlutoCell(value: result.name),
      'mean_score': PlutoCell(value: result.mean_score),
      'level': PlutoCell(value: result.level),
      'repository_url': PlutoCell(value: result.repository_url),
      'branch': PlutoCell(value: result.branch),
      'game_time': PlutoCell(value: result.game_time),
      'trials': PlutoCell(value: result.trial_number),
      'status': PlutoCell(value: result.status),
      'game_mode': PlutoCell(value: result.game_mode),
    };
    return cells;
  }
}
