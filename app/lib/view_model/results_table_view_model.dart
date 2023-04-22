import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/result_model.dart' as ResultModel;
import '../model/results_table_model.dart' as ResultsTableModel;

class ResultsTableStateNotifier extends StateNotifier<ResultsTableModel.ResultsTableModel> {
  final DBRepository _dbRepository;
  final int _limit = 5;
  final String _competition = "v4";
  final List<ResultModel.ResultModel> _fetchedResults = [];

  ResultsTableStateNotifier(this._dbRepository) : super(ResultsTableModel.ResultsTableModel([], false, true)){
    fetchResults(1);
  }
  Future<void> fetchResults(int page) async {
    state = ResultsTableModel.ResultsTableModel([], false, false);
    // if (_results.length < _limit * (page-1) + 1){
    //   List<ResultModel.ResultModel> _fetchedResults = await _dbRepository.getEvaluationResults(_limit, _competition);
    // }

    try{
      List<ResultModel.ResultModel> _results = await _dbRepository.getEvaluationResults(_limit, _competition);
      state = ResultsTableModel.ResultsTableModel(_results, false, false);
    } catch(e){
      print(e);
    }
  }
}