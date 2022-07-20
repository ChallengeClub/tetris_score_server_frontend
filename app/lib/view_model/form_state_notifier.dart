import '../repository/form_repository.dart';

abstract class FormState {
  const FormState();
}

class FormInitial extends FormState {
  const FormInitial();
}

class FormLoading extends FormState {
  const FormLoading();
}

class FormLoaded extends FormState {
  const FormLoaded();
}

class FormError extends FormState {
  final String message;
  const FormError(this.message);
}

class FormStateNotifier extends StateNotifier<FormState> {
  final FormRepository _formRepository;
  FormStateNotifier(this._formRepository): super(FormInitial);
  Future<void> checkIsExistRepository(String url) async{
    try{
      state = FormLoading();
      await _formRepository.fetchRepository(url);
      state = FormLoaded();
    } catch(e){
      state = FormError(e)
    }
  }
}