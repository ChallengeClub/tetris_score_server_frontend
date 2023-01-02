import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/result_model.dart';
import '../model/entry_model.dart';

abstract class DBRepository {
  Future<List<ResultModel>> getLatestResults();
  Future<List<EntryModel>> getEntries();
}

class DBRepositoryImpl implements DBRepository {
  @override
  Future<List<ResultModel>> getLatestResults() async {
    String? _api = dotenv.env['EVALUATION_REQUEST_API'];
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
  Future<List<EntryModel>> getEntries() async {
    print("get Entries pressed");
    String? _api = dotenv.env['EVALUATION_REQUEST_API'];
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
