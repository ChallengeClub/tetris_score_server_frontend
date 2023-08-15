import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../model/user_model.dart';
import '../error.dart' as Error;
import '../amplifyconfiguration.dart';

abstract class AuthRepository {
  Future<void> configAuth();
  Future<UserModel?> signIn();
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

  @override
  Future<UserModel?> signIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );
      safePrint('Sign in result: $result');
      return null;
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

}
