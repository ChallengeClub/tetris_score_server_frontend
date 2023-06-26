import 'package:state_notifier/state_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../repository/db_repository.dart';
import '../model/training_form_model.dart';

class TrainingDetailStateNotifier extends StateNotifier<TrainingModel?> {
  final DBRepository _dbRepository;
  TrainingDetailStateNotifier(this._dbRepository): super(null);

  Future<void> fetchTrainingDetail(String section, String id) async {
    try {
      state = await _dbRepository.getTrainingDetail(section, id);
    } catch(e){
      state = TrainingModel(section, id, "Error occured", e.toString(), "", "");
    }
  }
}