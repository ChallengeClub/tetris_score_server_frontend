import 'package:state_notifier/state_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../repository/db_repository.dart';
import '../repository/form_repository.dart';
import '../model/training_form_model.dart';

class TrainingFormStateNotifier extends StateNotifier<TrainingFormModel> {
  final FormRepository _formRepository;
  final DBRepository _dbRepository;
  final TrainingModel _training;
  TrainingFormStateNotifier(this._formRepository, this._dbRepository, this._training): super(TrainingFormModel(_training,"initialized", null, null)){
    fetchTrainingDetail(_training.section, _training.id);
  }

  Future<void> fetchTrainingDetail(String section, String id) async {
    try {
      TrainingModel training = await _dbRepository.getTrainingDetail(section, id);
      state = state.copyWith(training: training);
    } catch(e){
      state = state.copyWith(status: "error", error_message: e.toString());
    }
  }

  Future<void> submitCode(String code) async{
    // check internet connection
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = state.copyWith(status: "error", error_message: "internet disconnected");
      return;
    }
    try{
      Map<String, dynamic> res;
      state = state.copyWith(status: "submitting");
      res = await _formRepository.postTrainingCode(state.training!, code);
      state = res["status"] ? state.copyWith(status: "finished", results: res["results"].cast<String>()) : state.copyWith(status: "error", error_message: "failed to submit code to api");
    } catch(e){
      state = state.copyWith(status: "error", error_message: "error occured\n${e}");
    }
  }

  void initializeState(){
    state = state.copyWith(status: "initialized");
  }

  void setFormValidationErrorState(){
    state = state.copyWith(status: "error", error_message: "form validation error\nfix invalid forms");
  }
}