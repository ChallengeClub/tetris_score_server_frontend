import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../repository/file_repository.dart';
import '../model/entry_model.dart' as EntryModel;


class EntriesStateNotifier extends StateNotifier<List<EntryModel.EntryModel>> {
  final DBRepository _dbRepository;  
  final FileRepository _fileRepository;
  EntriesStateNotifier(this._dbRepository, this._fileRepository) : super([]){
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    try{
      state = []; // initialize state and display the circle indicator
      List<EntryModel.EntryModel> entries = await _dbRepository.getEntries();
      if (entries.length == 0){ // if no data in DB, use Example Entry
        entries = EntryModel.getExampleEntryModel();
      }
      entries.sort((b,a)=>a.created_at.compareTo(b.created_at));
      state = entries;
    } catch(e){
      print(e);
    }
  }

  Future<void> writeToFile() async {
    try{
      await _fileRepository.writeToCsv(state);
    } catch(e){
      print(e);
    }
  }
}