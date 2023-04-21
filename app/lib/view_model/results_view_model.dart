import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/result_model.dart' as ResultModel;


class ResultsStateNotifier extends StateNotifier<List<ResultModel.ResultModel>> {
  final DBRepository _dbRepository;
  final int _limit = 30;
  final String _competition = "v4";
  final List<ResultModel.ResultModel> _results = [];

  ResultsStateNotifier(this._dbRepository) : super([]){
    fetchResults(1);
  }
  Future<void> fetchResults(int page) async {
    state = [];
    // if (_results.length < _limit * (page-1) + 1){
    //   List<ResultModel.ResultModel> _fetchedResults = await _dbRepository.getEvaluationResults(_limit, _competition);
    // }

    try{
      state = await _dbRepository.getEvaluationResults(_limit, _competition);
    } catch(e){
      print(e);
    }
  }

  void sortResultsByCreatedAt(){
    state.sort((b, a) => a.created_at.compareTo(b.created_at));
  }
}