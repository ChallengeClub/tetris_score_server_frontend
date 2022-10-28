import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/result_model.dart';


class ResultNotifier extends StateNotifier<List<ResultModel>> {
  final DBRepository _dbRepository;  
  ResultNotifier(this._dbRepository) : super([]){
    fetchResults();
  }
  Future<void> fetchResults() async {
    try{
      state = await _dbRepository.getLatestResults();
    } catch(e){
      print(e);
    }
  }
}