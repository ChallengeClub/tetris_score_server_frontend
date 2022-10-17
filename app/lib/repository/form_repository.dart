import 'dart:math';
import 'package:http/http.dart' as http;
import '../model/form_model.dart';

abstract class FormRepository {
  Future<bool> checkExistBranch(FormModel msg);
}

class FormRepositoryImpl implements FormRepository {
  @override
  Future<bool> checkExistBranch(FormModel msg) async {
    var url = Uri.https('github.com', 'seigot/tetris/tree/master');
    var response = await http.get(url);
    print(response.statusCode);
    return true;
    }
}
