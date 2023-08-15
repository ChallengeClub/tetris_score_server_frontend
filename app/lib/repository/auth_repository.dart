import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:url_launcher/url_launcher.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../model/user_model.dart';
import '../error.dart' as Error;
import '../amplifyconfiguration.dart';

abstract class AuthRepository {
  Future<void> configAuth();
  // Future<UserModel?> signIn();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> configAuth() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }
  // @override
  // Future<UserModel?> signIn() async {
  //   if (_url==null){
  //     throw Error.APINotDefinedError();
  //   }
  //   try {
  //     String uri_string = "${_url}/login?response_type=code&client_id=${_client_id}&redirect_uri=${Uri.base.toString()}";
  //     final uri = Uri.parse(uri_string);
  //     // http.Response response = await http.get(uri);
  //     bool is_logined = await launchUrl(uri, webOnlyWindowName: "_self");
  //     print(is_logined);
  //     // ログイン成功時の処理を追加
  //   } catch (e) {
  //     print('Authentication failed: $e');
  //     // ログイン失敗時の処理を追加
  //   }
  // }

}
