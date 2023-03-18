import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/form_model.dart';
import '../model/score_evaluation_message.pb.dart';

abstract class FormRepository {
  Future<bool> checkExistBranch(FormModel msg);
  Future<bool> checkExistWeightFile(FormModel msg);
  Future<bool> sendRequestToAPI(FormModel msg);
  Future<bool> sendRequestToEntryAPI(FormModel msg);
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
    final uri = Uri.parse("${_api}/score_evaluation");
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
}
