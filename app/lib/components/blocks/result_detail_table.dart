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
      mode: PlutoGridMode.readOnly,
      configuration: PlutoGridConfiguration(
        columnSize: PlutoGridColumnSizeConfig(
          autoSizeMode: PlutoAutoSizeMode.scale,
        ),
        style: PlutoGridStyleConfig(
          columnHeight: 30.0,
          rowHeight: 30.0,
          defaultCellPadding: EdgeInsets.all(5.0),
          columnTextStyle: const TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 12, fontWeight: FontWeight.w600),
          cellTextStyle: const TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 12),
        ),
      ),
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
      PlutoColumn(
        title: 'Block Index',
        field: 'block_index',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Line Score Stat',
        field: 'line_score_stat',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Shape Info Stat',
        field: 'shape_info_stat',
        type: PlutoColumnType.text(),
      ),
    ];
    return res;
  }

  List<PlutoRow> getResultDetailRows(ResultModel.ResultModel _result){
    List<PlutoRow> _rows = [];
    for (int i = 0; i < _result.random_seeds.length; i++){
      PlutoRow _row = PlutoRow(
        cells: <String, PlutoCell> {
          'score': PlutoCell(value: _result.scores.length>i ? _result.scores[i] : null),
          'random_seed': PlutoCell(value: _result.random_seeds.length>i ? _result.random_seeds[i] : null),
          'gameover_count': PlutoCell(value: _result.gameover_counts.length>i ? _result.gameover_counts[i] : null),
          'block_index': PlutoCell(value: _result.block_indices.length>i ? _result.block_indices[i] : null),
          'line_score_stat': PlutoCell(value: _result.line_score_stats.length>i ? _result.line_score_stats[i] : null),
          'shape_info_stat': PlutoCell(value: _result.shape_info_stats.length>i ? _result.shape_info_stats[i] : null),
        }
      );
      _rows.add(_row);
    }
    return _rows;
  }
}
