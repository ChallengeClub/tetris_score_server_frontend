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
    RegExp exp = new RegExp(r'https://github.com/(.+)/(.+)$');
    RegExpMatch? match = exp.firstMatch(msg.repository_URL);
    var url = Uri.https('api.github.com', 'repos/${match!.group(1)}/${match!.group(2)}/branches/${msg.branch_name}');
    http.Response response = await http.get(url);
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
