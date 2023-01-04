import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/entry_model.dart' as EntryModel;
import '../parts/entry_dialog.dart' as EntryDialog;
import '../../view_model/providers.dart';

class EntryStatusTable extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<EntryModel.EntryModel> _entries = ref.watch(entryStateNotifierProvider);
    var _screenSize = MediaQuery.of(context).size;
    List<String> _columnList = this.getEntryColumns(_screenSize.width);

    int _currentSortColumn = 0;
    bool _isAscending = true;
    ref.read(entryStateNotifierProvider.notifier).sortEntriesByColumn("created_at", true);

    return SingleChildScrollView(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: DataTable(
          showCheckboxColumn: false,
          sortColumnIndex: _currentSortColumn,
          sortAscending: _isAscending,
          headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
          columns: _columnList.map(
            (String column) => DataColumn(
              label: Text(column),
              onSort: (sortColumnIndex, isSortAscending){
                _isAscending ^= true;
                ref.read(
                  entryStateNotifierProvider.notifier
                ).sortEntriesByColumn(column, isSortAscending);
              }
            )
          ).toList(),
          rows: _entries.map((EntryModel.EntryModel entry) => DataRow(
            onSelectChanged: (_) => EntryDialog.showEntryDialog(context,entry),
            cells: this.mapToDataCells(_screenSize.width, entry)
          )).toList()
        )
      ));
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