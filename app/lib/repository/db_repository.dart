import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/result_model.dart';

abstract class DBRepository {
  Future<List<ResultModel>> getLatestResults();
}

class DBRepositoryImpl implements DBRepository {
  @override
  Future<List<ResultModel>> getLatestResults() async {
    String? _api = dotenv.env['EVALUATION_REQUEST_API'];
    if (_api==null){
      return [];
    }
    final uri = Uri.parse("http://localhost:8000/results");
    http.Response result = await http.get(uri);
    var _map = convert.jsonDecode(result.body);
    List<dynamic> items = _map['Items'];
    List<ResultModel> results = items.map(
        (var item) => ResultModel.fromJson(item)
    ).toList();
    return results;
  }
}
