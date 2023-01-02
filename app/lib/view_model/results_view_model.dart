import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../repository/file_repository.dart';
import '../model/result_model.dart';


class ResultNotifier extends StateNotifier<List<ResultModel>> {
  final DBRepository _dbRepository;  
  final FileRepository _fileRepository;
  ResultNotifier(this._dbRepository, this._fileRepository) : super([]){
    fetchResults();
  }
  Future<void> fetchResults() async {
    try{
      state = await _dbRepository.getLatestResults();
    } catch(e){
      print(e);
    }
  }

  void sortResultsByCreatedAt(){
    state.sort((b, a) => a.created_at.compareTo(b.created_at));
  }

  Future<void> writeToFile() async {
    try{
      await _fileRepository.writeToCsv(state);
    } catch(e){
      print(e);
    }
  }
}