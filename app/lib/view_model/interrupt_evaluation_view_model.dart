import 'package:state_notifier/state_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../repository/db_repository.dart';
import '../model/result_model.dart';

abstract class InterruptionButtonState {
  const InterruptionButtonState();
}

class Enabled extends InterruptionButtonState {
  const Enabled();
}
class Disabled extends InterruptionButtonState {
  const Disabled();
}
class Requesting extends InterruptionButtonState {
  const Requesting();
}

class Succeeded extends InterruptionButtonState {
  const Succeeded();
}

class Error extends InterruptionButtonState {
  final String message;
  const Error(this.message);
}

class InterruptionButtonStateNotifier extends StateNotifier<InterruptionButtonState> {
  final DBRepository _dbRepository;
  final ResultModel _result;
  InterruptionButtonStateNotifier(this._dbRepository, this._result): super(Disabled()){
    initializeState();
  }

  Future<void> requestInterruption() async{
    // check internet connection
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = Error("error: internet disconnected");
      return;
    }
    try{
      String res;
      state = Requesting();
      res = await _dbRepository.interruptEvaluation(_result.id);
      if (res == ""){
        state = Succeeded();
      } else {
        state = Error(res);
      }
    } catch(e){
      state =Error("error occured\n${e}");
    }
  }

  void initializeState(){
    if (["waiting", "started", "evaluating"].contains(_result.status)){
      state = Enabled();
    } else {
      state = Disabled();
    }
  }
}