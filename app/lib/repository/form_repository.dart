import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/form_model.dart';
import '../model/score_evaluation_message.pb.dart';

abstract class FormRepository {
  Future<bool> checkExistBranch(FormModel msg);
  Future<void> sendRequestToAPI(FormModel msg);
}

class FormRepositoryImpl implements FormRepository {
  @override
  Future<bool> checkExistBranch(FormModel msg) async {
    var url = Uri.https('github.com', '${msg.user_name}/${msg.repository_name}/tree/${msg.branch_name}');
    var response = await http.get(url);
    print(dotenv.env['EVALUATION_REQUEST_API']);
    print(url);
    final bool res;
    if (response.statusCode == 200){
        res = true;
    }else{
        res = false;
    }
    return res;
  }
  
  @override
  Future<void> sendRequestToAPI(FormModel msg) async {
    ScoreEvaluationMessage protobuf_msg = msg.toProtobufMsg();
    print(protobuf_msg.toProto3Json());
    return Future.delayed(
      Duration(seconds: 2)
    );
  }
}
