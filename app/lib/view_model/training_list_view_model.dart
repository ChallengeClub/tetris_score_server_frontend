import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/training_form_model.dart';


class TrainingListStateNotifier extends StateNotifier<List<TrainingModel>> {
  final DBRepository _dbRepository;
  final String _section;
  TrainingListStateNotifier(this._dbRepository, this._section) : super([]){
    fetchTrainings();
  }

  Future<void> fetchTrainings() async {
    try{
      state = []; // initialize state and display the circle indicator
      List<TrainingModel> trainings = await _dbRepository.getTrainingList(_section);
      state = trainings;
    } catch(e){
      print(e);
    }
  }
}