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
    // check internet connection
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = FormError("error: internet disconnected");
      return;
    }
    try{
    bool res;
    state = FormSubmitting();

    res = await _formRepository.checkExistBranch(data);
    if (res==false){
      state = FormError("repository or branch doesn't exists");
      return;
    }
    res = await _formRepository.sendRequestToAPI(data);
    state = res ? FormSubmitted() : FormError("failed to submit form to api");
    } catch(e){
      state = FormError("error occured\n${e}");
    }
  }

  Future<void> submitEntryMessage(FormModel data) async{
    // check internet connection
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = FormError("error: internet disconnected");
      return;
    }
    try{
    bool res;
    state = FormSubmitting();

    res = await _formRepository.checkExistBranch(data);
    if (res==false){
      state = FormError("repository or branch doesn't exists");
      return;
    }
    res = await _formRepository.sendRequestToEntryAPI(data);
    state = res ? FormSubmitted() : FormError("failed to submit form to api");
    } catch(e){
      state = FormError("error occured\n${e}");
    }
  }

  String? checkRepositoryURLPattern(String? value){
    if (value == null || value.isEmpty) {
      state = FormError("invalid repository URL");
      return 'Please enter some text';
    }

    RegExp exp = new RegExp(r'https://github.com/(.+)/(.+)$');
    if (!exp.hasMatch(value)){
      state = FormError("invalid repository URL");
      return 'must match like "https://github.com/user/repository"';
    }
    return null;
  }

  void initializeState(){
    state = FormInitial();
  }

  void setFormValidationErrorState(){
    state = FormError("form validation error\nfix invalid forms");
  }
}