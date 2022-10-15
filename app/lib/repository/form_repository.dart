import 'dart:math';
import '../model/form_model.dart';

abstract class FormRepository {
  Future<bool> putRequest(FormModel msg);
}

class FormRepositoryImpl implements FormRepository {
  @override
  Future<bool> putRequest(FormModel msg) async {
    return Future.delayed(
      Duration(seconds: 2),
      () => true,
      );
    }
}
