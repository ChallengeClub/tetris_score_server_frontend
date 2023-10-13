import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../model/form_model.dart';
import '../model/training_form_model.dart';
import '../model/score_evaluation_message.pb.dart';

abstract class FormRepository {
  Future<bool> checkExistBranch(FormModel msg);
  Future<bool> checkExistWeightFile(FormModel msg);
  Future<bool> sendRequestToAPI(FormModel msg);
  Future<bool> sendRequestToEntryAPI(FormModel msg);
  Future<Map<String, dynamic>> postAlgorithmTrainingCode(TrainingModel msg, String code);
  Future<Map<String, dynamic>> postTetrisTrainingCode(TrainingModel msg, String code);
  Future<Map<String, dynamic>> postTurtleTrainingCode(TrainingModel training, String code);
}

class FormRepositoryImpl implements FormRepository {
  static const String? _api = const String.fromEnvironment('TETRIS_API');

  @override
  // this method must be called after formStateNotifier.checkRepositoryURLPattern
  Future<bool> checkExistBranch(FormModel msg) async {
    var url = Uri.https('api.github.com', 'repos/${msg.github_user_name}/${msg.github_repository_name}/branches/${msg.branch_name}');
    http.Response response = await http.head(url);
    return response.statusCode == 200;
  }

  @override
  Future<bool> checkExistWeightFile(FormModel msg) async {
    if (msg.predict_weight_path==""){
      return true;
    }
    var url = Uri.https(
      'api.github.com',
      'repos/${msg.github_user_name}/${msg.github_repository_name}/contents/${msg.predict_weight_path}',
      {
        'ref': msg.branch_name,
      },
    );
    http.Response response = await http.head(url);
    return response.statusCode == 200;
  }
  
  @override
  Future<bool> sendRequestToAPI(FormModel msg) async {
    ScoreEvaluationMessage protobuf_msg = msg.toProtobufMsg();
    if (_api==null){
      return false;
    }
    final uri = Uri.parse("${_api}/evaluation");
    http.Response response = await http.post(uri, body: base64.encode(protobuf_msg.writeToBuffer()));
    return response.statusCode == 200;
  }

  @override
  Future<bool> sendRequestToEntryAPI(FormModel msg) async {
    ScoreEvaluationMessage protobuf_msg = msg.toProtobufMsg();
    if (_api==null){
      return false;
    }
    final uri = Uri.parse("${_api}/entry");
    http.Response response = await http.post(uri, body: base64.encode(protobuf_msg.writeToBuffer()));
    return response.statusCode == 200;
  }

  @override
  Future<Map<String, dynamic>> postAlgorithmTrainingCode(TrainingModel training, String code) async {
    if (_api==null){
      Map<String, dynamic> result = {
        "status": false,
        "results": ["_api is not defined"],
      };
      return result;
    }
    final uri = Uri.parse("${_api}/trainings/algorithm/${training.id}");
    http.Response response = await http.post(uri, body: code);
    Map<String, dynamic> result = {
      "status": response.statusCode == 200,
      "results": jsonDecode(response.body),
    };
    return result;
  }

  @override
  Future<Map<String, dynamic>> postTetrisTrainingCode(TrainingModel training, String code) async {
    if (_api==null){
      Map<String, dynamic> result = {
        "status": false,
        "results": ["_api is not defined"],
      };
      return result;
    }
    final uri = Uri.parse("${_api}/trainings/tetris/${training.id}");
    http.Response response = await http.post(uri, body: code);
    Map<String, dynamic> result = {
      "status": response.statusCode == 200,
      "results": jsonDecode(response.body),
    };
    return result;
  }

  @override
  Future<Map<String, dynamic>> postTurtleTrainingCode(TrainingModel training, String code) async {
    if (_api==null){
      Map<String, dynamic> result = {
        "status": false,
        "results": ["_api is not defined"],
      };
      return result;
    }
    final uri = Uri.parse("${_api}/trainings/turtle");
    http.Response response = await http.post(uri, body: code);
    Map<String, dynamic> result = {
      "status": response.statusCode == 200,
      "response": base64Decode(response.body), // decode to image binary
    };

    return result;
  }
}
