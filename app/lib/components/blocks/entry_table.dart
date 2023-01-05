import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/entry_model.dart' as EntryModel;
import '../../model/entry_table_model.dart';
import '../parts/entry_dialog.dart' as EntryDialog;
import '../../view_model/providers.dart';

class EntryStatusTable extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EntryTable _entryTable = ref.watch(entryTableStateNotifierProvider);
    var _screenSize = MediaQuery.of(context).size;
    List<String> _columnList = this.getEntryColumns(_screenSize.width);

    return SingleChildScrollView(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: (() {
          if (_entryTable.entries.length == 0) {
          // 初期化後、通信中
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return DataTable(
            showCheckboxColumn: false,
            sortColumnIndex: _columnList.indexOf(_entryTable.sortColumn),
            sortAscending: _entryTable.isSortedAscending,
            columnSpacing: 20,
            headingRowColor: MaterialStateProperty.all(Colors.lime),
            columns: _columnList.map(
              (String column) => DataColumn(
                label: Text(column)
              )
            ).toList(),
            rows: _entryTable.entries.map((EntryModel.EntryModel entry) => DataRow(
              onSelectChanged: (_) => EntryDialog.showEntryDialog(context,entry),
              cells: this.mapToDataCells(_screenSize.width, entry)
            )).toList()
          );
        })()
      )
    );
  }
   
  List<String> getEntryColumns(var width){
    List<String> res = [ // for mobile size
        "created_at",
        "name",
        "level",
        "repository_url",
        "status"
      ];
    if (width >= 700){ // for desktop size
      res = [
        "created_at",
        "name",
        "status",
        "level",
        "repository_url",
        "branch",
        "game_mode",
      ];
    }
    return res;
  }

  List<DataCell> mapToDataCells(var width, EntryModel.EntryModel entry){
    List<DataCell> cells = [
        DataCell(Text(EntryModel.datetimeToString(entry.created_at))),
        DataCell(Text(entry.name)),
        DataCell(Text(entry.level.toString())),
        DataCell(Text(entry.repository_url)),
        DataCell(Text(entry.status)),
      ];
    if (width >= 700){ // for desktop size
      cells = [
        DataCell(Text(EntryModel.datetimeToString(entry.created_at))),
        DataCell(Text(entry.name)),
        DataCell(Text(entry.status)),
        DataCell(Text(entry.level.toString())),
        DataCell(Text(entry.repository_url)),
        DataCell(Text(entry.branch)),
        DataCell(Text(entry.game_mode)),
      ];
    }
    return cells;
  }
}