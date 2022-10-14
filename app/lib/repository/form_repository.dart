import 'dart:math';

abstract class FormRepository {
  Future<void> putRequest(String msg);
}

class FormRepositoryImpl implements FormRepository {
  int value = 0;
  @override
  Future<void> putRequest(String msg) async {
    return Future.delayed(Duration(seconds: 2));
    }
}
