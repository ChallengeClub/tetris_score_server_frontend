import 'dart:async';
import 'dart:io';
import 'dart:html';
import 'package:csv/csv.dart';

import '../model/result_model.dart';

abstract class FileRepository {
  Future<void> writeToCsv(List<ResultModel> results);
}

class FileRepositoryImpl implements FileRepository {
  @override
  Future<void> writeToCsv(List<ResultModel> results) async {
    final header = getHeader();
    final rows = results.map((result) => result.toCsv()).toList();
    final csv = const ListToCsvConverter().convert(
        [header, ...rows],
    );
    print(csv);
    AnchorElement anchorElement = AnchorElement(
      href: 'data:text/plain;charset=utf-8,$csv',
    );
    anchorElement
        ..setAttribute('download', 'entry.csv')
        ..click();
  }
}
