import '../repository/form_repository.dart';
import '../model/form_model.dart';
import 'package:state_notifier/state_notifier.dart';

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
    try{
      state = FormSubmitting();
      bool res =  await _formRepository.checkExistBranch(data);
      state = res ? FormSubmitted() : FormError("failed to confirm branch exists");
      await _formRepository.sendRequestToAPI(data);    
    } catch(e){
      state = FormError("error occured");
      print(e);
    }
  }
}