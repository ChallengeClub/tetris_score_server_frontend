import 'dart:math';
import 'package:http/http.dart' as http;
import '../model/form_model.dart';

abstract class FormRepository {
  Future<bool> checkExistBranch(FormModel msg);
}

class FormRepositoryImpl implements FormRepository {
  @override
  Future<bool> checkExistBranch(FormModel msg) async {
    var url = Uri.https('github.com', '${msg.user_name}/${msg.repository_name}/tree/${msg.branch_name}');
    var response = await http.get(url);
    print(url);
    final bool res;
    if (response.statusCode == 200){
        res = true;
    }else{
        res = false;
    }
    return res;
    }
}
