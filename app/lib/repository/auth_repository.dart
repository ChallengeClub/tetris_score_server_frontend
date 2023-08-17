import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../model/user_model.dart';
import '../error.dart' as Error;
import '../amplifyconfiguration.dart' as AmplifyConfiguration;

abstract class AuthRepository {
  Future<void> configAuth();
  Future<UserModel?> signIn();
  Future<UserModel?> signOut();
  Future<UserModel?> checkLoginSatatus();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> configAuth() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(AmplifyConfiguration.amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Future<UserModel?> signIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      return null;
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  @override
  Future<UserModel?> signOut() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
      return null;
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
      return null;
    }
  }

  @override
  Future<UserModel?> checkLoginSatatus() async {
    try {
      final authSession = await Amplify.Auth.fetchAuthSession();
      if (authSession.isSignedIn) {
        final user = await Amplify.Auth.getCurrentUser();
        return UserModel(
          user.userId,
          user.username,
          "https://github.com/seigot/tetris.git"
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
