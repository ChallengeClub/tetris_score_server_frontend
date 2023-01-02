import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../repository/file_repository.dart';
import '../model/entry_model.dart';


class EntryNotifier extends StateNotifier<List<EntryModel>> {
  final DBRepository _dbRepository;  
  final FileRepository _fileRepository;
  EntryNotifier(this._dbRepository, this._fileRepository) : super([]){
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    try{
      state = await _dbRepository.getEntries();
    } catch(e){
      print(e);
    }
  }

  void sortEntriesByCreatedAt(){
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