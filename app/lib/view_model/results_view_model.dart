import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/result_model.dart' as ResultModel;


class ResultsStateNotifier extends StateNotifier<List<ResultModel.ResultModel>> {
  final DBRepository _dbRepository;
  ResultsStateNotifier(this._dbRepository) : super([]){
    fetchResults();
  }
  Future<void> fetchResults() async {
    state = [];
    try{
      state = await _dbRepository.getEvaluationResults(30, "v4");
    } catch(e){
      print(e);
    }
  }

  void sortResultsByCreatedAt(){
    state.sort((b, a) => a.created_at.compareTo(b.created_at));
  }
}