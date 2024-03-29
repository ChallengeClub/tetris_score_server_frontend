import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/result_model.dart';
import '../model/entry_model.dart';
import '../model/news_model.dart';
import '../model/training_form_model.dart';
import '../envs.dart' as Env;

abstract class DBRepository {
  Future<Map<String, dynamic>> getEvaluationResults(int _limit, String _competition, dynamic? _exclusive_start_key);
  Future<ResultModel> getResultDetailById(String _id);
  Future<List<EntryModel>> getEntries();
  Future<String> interruptEvaluation(String _id);
  Future<List<NewsModel>> getNews();
  Future<NewsModel> getNewsDetailById(String _id);
  Future<List<TrainingModel>> getTrainingList(String _section);
  Future<TrainingModel> getTrainingDetail(String _section, String _id);
}

class DBRepositoryImpl implements DBRepository {
  @override
  Future<Map<String, dynamic>> getEvaluationResults(int _limit, String _competition, dynamic? _exclusive_start_key) async {
    String uri_string = "${Env.EnvironmentVariables.apiUrl}/results?limit=${_limit}&competition=${_competition}";
    if (_exclusive_start_key!=null){
      uri_string += "&exclusive_start_key=${convert.jsonEncode(_exclusive_start_key)}";
    }
    final uri = Uri.parse(uri_string);
    http.Response result = await http.get(uri);
    dynamic _map = convert.jsonDecode(result.body);
    List<ResultModel> _results = _map["Items"].map<ResultModel>(
        (dynamic _item) => ResultModel.fromJson(_item)
    ).toList();
    return {
      "Results": _results,
      "LastEvaluatedKey": _map["LastEvaluatedKey"],
    };
  }

  @override
  Future<ResultModel> getResultDetailById(String _id) async {
    final uri = Uri.parse("${Env.EnvironmentVariables.apiUrl}/result/${_id}");
    http.Response result = await http.get(uri);
    dynamic _map = convert.jsonDecode(result.body);
    ResultModel _result = ResultModel.fromJson(_map);
    return _result;
  }

  @override
  Future<List<EntryModel>> getEntries() async {
    final uri = Uri.parse("${Env.EnvironmentVariables.apiUrl}/entries");
    http.Response result = await http.get(uri);
    List<dynamic> _map = convert.jsonDecode(result.body);
    List<EntryModel> results = _map.map(
        (dynamic item) => EntryModel.fromJson(item)
    ).toList();
    return results;
  }

  @override
  Future<String> interruptEvaluation(String _id) async {
    final uri = Uri.parse("${Env.EnvironmentVariables.apiUrl}/evaluation/cancel/${_id}");
    http.Response result = await http.put(uri);
    String res = "";
    if (result.statusCode!=200){
      res = result.body;
    }
    return res;
  }

  @override
  Future<List<NewsModel>> getNews() async {
    final uri = Uri.parse("${Env.EnvironmentVariables.apiUrl}/news");
    http.Response result = await http.get(uri);
    List<dynamic> _map = convert.jsonDecode(result.body);
    List<NewsModel> results = _map.map(
        (dynamic item) => NewsModel.fromJson(item)
    ).toList();
    return results;
  }

  @override
  Future<NewsModel> getNewsDetailById(String _id) async {
    final uri = Uri.parse("${Env.EnvironmentVariables.apiUrl}/news/${_id}");
    http.Response result = await http.get(uri);
    dynamic _map = convert.jsonDecode(result.body);
    NewsModel _result = NewsModel.fromJson(_map);
    return _result;
  }

  @override
  Future<TrainingModel> getTrainingDetail(String _section, String _id) async {
    final uri = Uri.parse("${Env.EnvironmentVariables.apiUrl}/training/${_section}/${_id}");
    http.Response result = await http.get(uri);
    dynamic _map = convert.jsonDecode(result.body);
    TrainingModel _result = TrainingModel.fromJson(_map);
    return _result;
  }

  @override
  Future<List<TrainingModel>> getTrainingList(String _section) async {
    final uri = Uri.parse("${Env.EnvironmentVariables.apiUrl}/trainings/${_section}");
    http.Response result = await http.get(uri);
    dynamic _map = convert.jsonDecode(result.body);
    List<TrainingModel> results = _map["Items"].map<TrainingModel>(
        (dynamic item) => TrainingModel.fromJson(item)
    ).toList();
    return results;
  }
}
