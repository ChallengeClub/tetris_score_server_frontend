import 'dart:async';
import 'dart:io';
import 'dart:html';
import 'package:csv/csv.dart';

import '../model/entry_model.dart';

abstract class FileRepository {
  Future<void> writeToCsv(List<EntryModel> entries);
}

class FileRepositoryImpl implements FileRepository {
  @override
  Future<void> writeToCsv(List<EntryModel> entries) async {
    final header = getHeader();
    final rows = entries.map((entry) => entry.toCsv()).toList();
    final csv = const ListToCsvConverter().convert(
        [header, ...rows],
    );
    AnchorElement anchorElement = AnchorElement(
      href: 'data:text/plain;charset=utf-8,$csv',
    );
    anchorElement
        ..setAttribute('download', 'entry.csv')
        ..click();
  }
}
