import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/user_model.dart';
import '../error.dart' as Error;

abstract class AuthRepository {
  Future<UserModel?> siginIn();
}

class AuthRepositoryImpl implements AuthRepository {
  static const String? _url = const String.fromEnvironment('TETRIS_AUTH_URL');
  static const String? _client_id = const String.fromEnvironment('TETRIS_AUTH_CLIENT_ID');

  @override
  Future<UserModel?> signIn(){
    try {
      var url = Uri.https(_url, 'login', {'response_type':'code', 'client_id': _client_id, 'redirect_uri'=Uri.base.toString()});
      http.Response response = await http.get(url);
      print(response);
      print(res)
      // ログイン成功時の処理を追加
    } catch (e) {
      print('Authentication failed: $e');
      // ログイン失敗時の処理を追加
    }
  }

}
