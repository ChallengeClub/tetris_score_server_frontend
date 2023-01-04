import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../repository/file_repository.dart';
import '../model/entry_model.dart';
import '../model/entry_table_model.dart';


class EntryTableStateNotifier extends StateNotifier<EntryTable> {
  final DBRepository _dbRepository;  
  final FileRepository _fileRepository;
  EntryTableStateNotifier(this._dbRepository, this._fileRepository) : super(EntryTable([], "create_at", false)){
    fetchEntries();
  }

  Future<String> fetchEntries() async {
    try{
      List<EntryModel> entries = await _dbRepository.getEntries();
      if (entries.length == 0){
        entries = getExampleEntryModel();
      }
      state = EntryTable(
        entries,
        "created_at",
        false
      );
      print("fetched data");
      return "Succeeded";
    } catch(e){
      print(e);
      return "Failed";
    }
  }

  Future<void> writeToFile() async {
    try{
      await _fileRepository.writeToCsv(state.entries);
    } catch(e){
      print(e);
    }
  }
}