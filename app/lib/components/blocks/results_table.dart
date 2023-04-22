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

  // Future<PlutoLazyPaginationResponse> fetch(
  //   PlutoLazyPaginationRequest request,
  // ) async {
  //   List<PlutoRow> tempList = fakeFetchedRows;

  //   // If you have a filtering state,
  //   // you need to implement it so that the user gets data from the server
  //   // according to the filtering state.
  //   //
  //   // request.page is 1 when the filtering state changes.
  //   // This is because, when the filtering state is changed,
  //   // the first page must be loaded with the new filtering applied.
  //   //
  //   // request.filterRows is a List<PlutoRow> type containing filtering information.
  //   // To convert to Map type, you can do as follows.
  //   //
  //   // FilterHelper.convertRowsToMap(request.filterRows);
  //   //
  //   // When the filter of abc is applied as Contains type to column2
  //   // and 123 as Contains type to column3, for example
  //   // It is returned as below.
  //   // {column2: [{Contains: 123}], column3: [{Contains: abc}]}
  //   //
  //   // If multiple filtering conditions are set in one column,
  //   // multiple conditions are included as shown below.
  //   // {column2: [{Contains: abc}, {Contains: 123}]}
  //   //
  //   // The filter type in FilterHelper.defaultFilters is the default,
  //   // If there is user-defined filtering,
  //   // the title set by the user is returned as the filtering type.
  //   // All filtering can change the value returned as a filtering type by changing the name property.
  //   // In case of PlutoFilterTypeContains filter, if you change the static type name to include
  //   // PlutoFilterTypeContains.name = 'include';
  //   // {column2: [{include: abc}, {include: 123}]} will be returned.
  //   if (request.filterRows.isNotEmpty) {
  //     final filter = FilterHelper.convertRowsToFilter(
  //       request.filterRows,
  //       stateManager.refColumns,
  //     );

  //     tempList = fakeFetchedRows.where(filter!).toList();
  //   }

  //   // If there is a sort state,
  //   // you need to implement it so that the user gets data from the server
  //   // according to the sort state.
  //   //
  //   // request.page is 1 when the sort state changes.
  //   // This is because when the sort state changes,
  //   // new data to which the sort state is applied must be loaded.
  //   if (request.sortColumn != null && !request.sortColumn!.sort.isNone) {
  //     tempList = [...tempList];

  //     tempList.sort((a, b) {
  //       final sortA = request.sortColumn!.sort.isAscending ? a : b;
  //       final sortB = request.sortColumn!.sort.isAscending ? b : a;

  //       return request.sortColumn!.type.compare(
  //         sortA.cells[request.sortColumn!.field]!.valueForSorting,
  //         sortB.cells[request.sortColumn!.field]!.valueForSorting,
  //       );
  //     });
  //   }

  //   final page = request.page;
  //   const pageSize = 100;
  //   final totalPage = (tempList.length / pageSize).ceil();
  //   final start = (page - 1) * pageSize;
  //   final end = start + pageSize;

  //   Iterable<PlutoRow> fetchedRows = tempList.getRange(
  //     max(0, start),
  //     min(tempList.length, end),
  //   );

  //   await Future.delayed(const Duration(milliseconds: 500));

  //   return Future.value(PlutoLazyPaginationResponse(
  //     totalPage: totalPage,
  //     rows: fetchedRows.toList(),
  //   ));
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultsTableModel.ResultsTableModel _results_table = ref.watch(resultsTableStateNotifierProvider);
    
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
          context.push('/server/results/${_selectedResultId}');
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
        // createFooter: (stateManager) {
        //   return Text("This is footer");
        // },
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
