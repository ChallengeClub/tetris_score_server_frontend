import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/form_model.dart';
import '../model/score_evaluation_message.pb.dart';

abstract class FormRepository {
  Future<bool> checkExistBranch(FormModel msg);
  Future<bool> sendRequestToAPI(FormModel msg);
}

class FormRepositoryImpl implements FormRepository {
  @override
  Future<bool> checkExistBranch(FormModel msg) async {
    var url = Uri.https('api.github.com', 'repos/${msg.user_name}/${msg.repository_name}/branches/${msg.branch_name}');
    var response = await http.get(url);
    bool res;
    if (response.statusCode == 200){
        res = true;
    }else{
        res = false;
    }
    return res;
  }
  
  @override
  Future<bool> sendRequestToAPI(FormModel msg) async {
    ScoreEvaluationMessage protobuf_msg = msg.toProtobufMsg();
    String? _api = dotenv.env['EVALUATION_REQUEST_API'];
    if (_api==null){
      return false;
    }
    final uri = Uri.parse("${_api}/score_evaluation");
    var response = await http.post(uri, body: base64.encode(protobuf_msg.writeToBuffer()));
    bool res;
    if (response.statusCode == 200){
        res = true;
    }else{
        res = false;
    }
    return res;
  }
}
