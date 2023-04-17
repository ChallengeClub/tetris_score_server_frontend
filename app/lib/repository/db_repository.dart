import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/result_model.dart';
import '../model/entry_model.dart';
import '../error.dart' as Error;

abstract class DBRepository {
  Future<List<ResultModel>> getEvaluationResults(int _limit, String _competition, [String _exclusive_start_key=""]);
  Future<ResultModel> getResultDetailById(String _id);
  Future<List<EntryModel>> getEntries();
}

class DBRepositoryImpl implements DBRepository {
  static const String? _api = const String.fromEnvironment('TETRIS_API');

  @override
  Future<List<ResultModel>> getEvaluationResults(int _limit, String _competition, [String _exclusive_start_key=""]) async {
    if (_api==null){
      throw Error.APINotDefinedError();
    }
    var uri_string = "${_api}/results?limit=${_limit}&competition=${_competition}";
    if (_exclusive_start_key!=""){
      uri_string += "&exclusive_start_key=${_exclusive_start_key}";
    }
    final uri = Uri.parse(uri_string);
    http.Response result = await http.get(uri);
    List<dynamic> _map = convert.jsonDecode(result.body);
    List<ResultModel> results = _map.map(
        (dynamic item) => ResultModel.fromJson(item)
    ).toList();
    return results;
  }

  @override
  Future<ResultModel> getResultDetailById(String _id) async {
    if (_api==null){
      throw Error.APINotDefinedError();
    }
    final uri = Uri.parse("${_api}/result/${_id}");
    http.Response result = await http.get(uri);
    dynamic _map = convert.jsonDecode(result.body);
    ResultModel _result = ResultModel.fromJson(_map);
    return _result;
  }

  @override
  Future<List<EntryModel>> getEntries() async {
    if (_api==null){
      throw Error.APINotDefinedError();
    }
    final uri = Uri.parse("${_api}/entries");
    http.Response result = await http.get(uri);
    List<dynamic> _map = convert.jsonDecode(result.body);
    List<EntryModel> results = _map.map(
        (dynamic item) => EntryModel.fromJson(item)
    ).toList();
    return results;
  }
}
