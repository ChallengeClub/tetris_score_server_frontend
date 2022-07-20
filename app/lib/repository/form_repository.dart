import 'dart:math';

abstract class FormRepository {
  Future<void> fetchRepository(String url);
}

class FormRepositoryImpl implements FormRepository {
  int value = 0;
  @override
  Future<void> fetchRepository(String url) async {
    return Future.delayed(Duration(seconds: 2))
    };
}
