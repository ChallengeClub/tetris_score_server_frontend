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

  void sortEntriesByColumn(String _column, bool _isAscending){
    print("sortEntries called: $_isAscending, $_column");
    if (_isAscending){
      state = state..sort((a, b) => a.getMember(_column).compareTo(b.getMember(_column)));
    } else {
      state = state..sort((b, a) => a.getMember(_column).compareTo(b.getMember(_column)));
    }
    print(state);
  }

  Future<void> writeToFile() async {
    try{
      await _fileRepository.writeToCsv(state);
    } catch(e){
      print(e);
    }
  }
}