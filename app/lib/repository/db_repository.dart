import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/result_model.dart';
import '../model/entry_model.dart';

abstract class DBRepository {
  Future<List<ResultModel>> getLatestResults();
  Future<ResultModel> getResultDetailById(String _id);
  Future<List<EntryModel>> getEntries();
}

class DBRepositoryImpl implements DBRepository {
  static const String? _api = const String.fromEnvironment('TETRIS_API');

  @override
  Future<List<ResultModel>> getLatestResults() async {
    if (_api==null){
      return [];
    }
    final uri = Uri.parse("${_api}/results");
    http.Response result = await http.get(uri);
    var _map = convert.jsonDecode(result.body);
    List<dynamic> items = _map['Items'];
    List<ResultModel> results = items.map(
        (var item) => ResultModel.fromJson(item)
    ).toList();

    return results;
  }
  @override
  Future<ResultModel> getResultDetailById(String _id) async {
    if (_api==null){
      return;
    }
    final uri = Uri.parse("${_api}/result/${_id}");
    http.Response result = await http.get(uri);
    var _map = convert.jsonDecode(result.body);
    dynamic item = _map['Item'];
    ResultModel result = ResultModel.fromJson(item);
    return result;
  }

  @override
  Future<List<EntryModel>> getEntries() async {
    if (_api==null){
      return [];
    }
    final uri = Uri.parse("${_api}/entries");
    http.Response result = await http.get(uri);
    var _map = convert.jsonDecode(result.body);
    List<dynamic> items = _map['Items'];    
    List<EntryModel> results = items.map(
        (var item) => EntryModel.fromJson(item)
    ).toList();
    return results;
  }
}
