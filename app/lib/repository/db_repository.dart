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
    // String? _api = dotenv.env['EVALUATION_REQUEST_API'];
    // if (_api==null){
    //   return [];
    // }
    // final uri = Uri.parse("${_api}/results");
    // http.Response result = await http.get(uri);
    // var _map = convert.jsonDecode(result.body);
    // List<dynamic> items = _map['Items'];
    List<dynamic> items = [
      {
        "CreatedAt": 1000001,
        "Status": "W",
        "RepositoryURL": "https://github.com/seigot/tetris",
        "Branch": "master",
        "MeanScore": 100
      },
      {
        "CreatedAt": 120000100,
        "Status": "S",
        "RepositoryURL": "https://github.com/seigot/tetris",
        "Branch": "master",
        "MeanScore": 1000
      },
    ];
    
    List<ResultModel> results = items.map(
        (var item) => ResultModel.fromJson(item)
    ).toList();
    return results;
  }
}
