import 'dart:math';
import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/result_model.dart';
import '../model/results_table_model.dart';

class ResultsTableStateNotifier extends StateNotifier<ResultsTableModel> {
  final DBRepository _dbRepository;
  final int _limit = 20;
  final String _competition = "v4";
  Map<String, dynamic> response = {};
  List<ResultModel> fetchedResults = [];
  List<dynamic> lastEvaluatedKeys = []; // lastExclusiveKeys.length>n represents page n has next page

  ResultsTableStateNotifier(this._dbRepository) : super(ResultsTableModel([], false, false, 0)){
    refresh();
  }
  Future<void> refresh() async {
    fetchedResults = [];
    state = ResultsTableModel([], false, false, 0);
    try{
      await moveToPage(1);
    } catch(e) {
      print(e);
    }
  }

  Future<void> moveToPage(int page) async {
    state = ResultsTableModel([], false, false, page);
    bool is_page_already_fetched = fetchedResults.length > (page-1)*_limit;

    if (!is_page_already_fetched){
      if (page==1){
        response = await _dbRepository.getEvaluationResults(_limit, _competition, null);
      } else {
        response = await _dbRepository.getEvaluationResults(_limit, _competition, lastEvaluatedKeys[page-2]);
      }
      fetchedResults.addAll(response["Results"]);
      if (response["LastEvaluatedKey"] != ""){
        lastEvaluatedKeys.add(response["LastEvaluatedKey"]);
      }
    }
    bool is_next_page_available = lastEvaluatedKeys.length >= page;
    List<ResultModel> results = fetchedResults.sublist(max(0, (page-1)*_limit), min(fetchedResults.length, page*_limit));
    state = ResultsTableModel(results, page>1, is_next_page_available, page);
  }

  Future<void> moveToNextPage() async {
    await moveToPage(state.page+1);
  }

  Future<void> moveToBeforePage() async {
    await moveToPage(state.page-1);
  }
}