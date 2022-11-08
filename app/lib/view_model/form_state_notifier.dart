import '../repository/form_repository.dart';
import '../model/form_model.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class FormState {
  const FormState();
}

class FormInitial extends FormState {
  const FormInitial();
}
class FormSubmitting extends FormState {
  const FormSubmitting();
}

class FormSubmitted extends FormState {
  const FormSubmitted();
}

class FormError extends FormState {
  final String message;
  const FormError(this.message);
}

class FormStateNotifier extends StateNotifier<FormState> {
  final FormRepository _formRepository;
  FormStateNotifier(this._formRepository): super(FormInitial());
  Future<void> submitMessage(FormModel data) async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = FormError("error internet disconnected");
    }else{
      try{
      bool res;
      state = FormSubmitting();
      res = await _formRepository.checkExistBranch(data);
      if (res==false){
        state = FormError("no such repository or branch\ngithub.com/${data.user_name}/${data.repository_name}/${data.branch_name}");
        return;
      }
      res = await _formRepository.sendRequestToAPI(data);
      state = res ? FormSubmitted() : FormError("failed to submit form to api");
      } catch(e){
        state = FormError("error occured\n${e}");
      }
    }
    
  }
  void initializeState(){
    state = FormInitial();
  }
}