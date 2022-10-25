import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/result_model.dart';

abstract class DBRepository {
  Future<List<ResultModel>> getLatestResults();
}

class DBRepositoryImpl implements DBRepository {
  @override
  Future<List<ResultModel>> getLatestResults() async {
    List<ResultModel> results;
    results = [
        ResultModel("https://github.com/seigot/tetris", "succeeded", "master", 1665154184000, 1020),
        ResultModel("https://github.com/seigot/tetris", "succeeded", "master", 1665154004000, 1230)
    ];
    var response = await Future.delayed(Duration(seconds: 1), () {
      return results;
    });
    return response;
  }
}
