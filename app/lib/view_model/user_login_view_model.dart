import 'package:state_notifier/state_notifier.dart';

import '../repository/auth_repository.dart';
import '../model/user_model.dart';


class UserLoginStateNotifier extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;
  
  UserLoginStateNotifier(this._authRepository) : super(null){}

  Future<void> loginById() async {
    try{
      state = await _authRepository.siginIn();
    } catch(e){
      print(e);
    }
  }
}