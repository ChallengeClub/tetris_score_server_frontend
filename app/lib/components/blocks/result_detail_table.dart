import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../model/result_model.dart' as ResultModel;

class ResultDetailTable extends HookConsumerWidget{
  final ResultModel.ResultModel _result;
  ResultDetailTable(this._result);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PlutoColumn> _columnList = this.getResultDetailColumns();
    List<PlutoRow> _rowList = this.getResultDetailRows(_result);

    return PlutoGrid(
      columns: _columnList,
      rows: _rowList,
    );
  }
    
  List<PlutoColumn> getResultDetailColumns(){
    List<PlutoColumn> res = [
      PlutoColumn(
        title: 'Score',
        field: 'score',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Random Seed',
        field: 'random_seed',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Gameover Count',
        field: 'gameover_count',
        type: PlutoColumnType.number(),
      ),
      // PlutoColumn(
      //   title: 'Block Index',
      //   field: 'block_index',
      //   type: PlutoColumnType.number(),
      // ),
      // PlutoColumn(
      //   title: 'Line Score Stat',
      //   field: 'line_score_stat',
      //   type: PlutoColumnType.text(),
      // ),
      // PlutoColumn(
      //   title: 'Shape Info Stat',
      //   field: 'shape_info_stat',
      //   type: PlutoColumnType.text(),
      // ),
    ];
    return res;
  }

  List<PlutoRow> getResultDetailRows(ResultModel.ResultModel _result){
    List<PlutoRow> _rows = [];
    for (int i = 0; i < _result.scores.length; i++){
      PlutoRow _row = PlutoRow(
        cells: <String, PlutoCell> {
          'score': PlutoCell(value: 0),
          'random_seed': PlutoCell(value: 0),
          'gameover_count': PlutoCell(value: 0),
        }
      );
      _rows.add(_row);
    }
    return _rows;
  }
}
