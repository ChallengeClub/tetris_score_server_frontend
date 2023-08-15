import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:state_notifier/state_notifier.dart';

import '../repository/auth_repository.dart';
import '../model/user_model.dart';


class UserLoginStateNotifier extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;
  
  UserLoginStateNotifier(this._authRepository) : super(null){
    configAuth();
  }

  Future<void> configAuth() async {
    try{
      await _authRepository.configAuth();
    } catch(e){
      print(e);
    }
  }
  

  Future<void> signIn() async {
    try{
      state = await _authRepository.signIn();
      print("loginButton pressed");
    } catch(e){
      print(e);
    }
  }
}