import '../repository/form_repository.dart';
import 'package:state_notifier/state_notifier.dart';

abstract class FormState {
  const FormState();
}

class FormInitial extends FormState {
  const FormInitial();
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
  FormStateNotifier(this._formRepository): super(FormInitial);
  Future<void> submitMessage(String msg) async{
    try{
      await _formRepository.putRequest(msg);
      state = FormSubmitted();
    } catch(e){
      state = FormError(e);
    }
  }
}