import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/result_model.dart' as ResultModel;


class ResultDetailStateNotifier extends StateNotifier<ResultModel.ResultModel> {
  final DBRepository _dbRepository;
  
  ResultDetailStateNotifier(this._dbRepository) : super(){
    
  }
  Future<void> fetchResultById(String _id) async {
    try{
      state = await _dbRepository.getResultDetailById(_id);
    } catch(e){
      print(e);
    }
  }
}