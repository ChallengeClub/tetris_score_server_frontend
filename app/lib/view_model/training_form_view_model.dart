import 'package:state_notifier/state_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../repository/form_repository.dart';
import '../model/training_form_model.dart';

abstract class TrainingFormState {
  const TrainingFormState();
}

class TrainingFormInitial extends TrainingFormState {
  const TrainingFormInitial();
}
class TrainingFormSubmitting extends TrainingFormState {
  const TrainingFormSubmitting();
}

class TrainingEvaluationFinished extends TrainingFormState {
  final List<String> results;
  const TrainingEvaluationFinished(this.results);
}

class TrainingFormError extends TrainingFormState {
  final String message;
  const TrainingFormError(this.message);
}

class TrainingFormStateNotifier extends StateNotifier<TrainingFormState> {
  final FormRepository _formRepository;
  final TrainingModel _training;
  TrainingFormStateNotifier(this._formRepository, this._training): super(TrainingFormInitial());

  Future<void> submitCode(TrainingFormModel data) async{
    // check internet connection
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = TrainingFormError("error: internet disconnected");
      return;
    }
    try{
      Map<String, dynamic> res;
      state = TrainingFormSubmitting();
      res = await _formRepository.postTrainingCode(data);
      state = res["status"] ? TrainingEvaluationFinished(res["results"].cast<String>()) : TrainingFormError("failed to submit code to api");
    } catch(e){
      state = TrainingFormError("error occured\n${e}");
    }
  }

  void initializeState(){
    state = TrainingFormInitial();
  }

  void setFormValidationErrorState(){
    state = TrainingFormError("form validation error\nfix invalid forms");
  }
}