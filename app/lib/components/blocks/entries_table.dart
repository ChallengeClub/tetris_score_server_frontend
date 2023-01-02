import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/entry_model.dart' as EntryModel;
import '../../view_model/providers.dart';

class EntryStatusTable extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<EntryModel.EntryModel> _entries = ref.watch(entryStateNotifierProvider);
    ref.read(entryStateNotifierProvider.notifier).sortEntriesByCreatedAt();
    var _screenSize = MediaQuery.of(context).size;
    List<String> _columnList = this.getEntryColumns(_screenSize.width);

    return SingleChildScrollView(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: DataTable(
          showCheckboxColumn: false,
          columns: _columnList.map((String column) => DataColumn(label: Text(column))).toList(),
          rows: _entries.map((EntryModel.EntryModel entry) => DataRow(
            cells: this.mapToDataCells(_screenSize.width, entry)
          )).toList()
        )
      ));
  }
  List<String> getEntryColumns(var width){
    List<String> res = [ // for mobile size
        "name",
        "created at",
        "level",
        "repository url",
        "status"
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
      ];
    }
    return res;
  }

  List<DataCell> mapToDataCells(var width, EntryModel.EntryModel entry){
    List<DataCell> cells = [
        DataCell(Text(entry.name)),
        DataCell(Text(EntryModel.datetimeToString(entry.created_at))),
        DataCell(Text(entry.level.toString())),
        DataCell(Text(entry.repository_url)),
        DataCell(Text(entry.status)),
      ];
    if (width >= 700){ // for desktop size
      cells = [
        DataCell(Text(entry.name)),
        DataCell(Text(EntryModel.datetimeToString(entry.created_at))),
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