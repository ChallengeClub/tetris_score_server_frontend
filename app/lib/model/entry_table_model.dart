import 'package:freezed_annotation/freezed_annotation.dart';

import 'entry_model.dart';
part 'entry_table_model.freezed.dart';

@freezed
class EntryTable with _$EntryTable {
  const factory EntryTable(
    List<EntryModel> entries,
    String sortColumn,
    bool isSortedAscending
  ) = _EntryTable;
}