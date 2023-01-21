import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'form_view_model.dart';
import 'results_view_model.dart';
import 'entries_view_model.dart';
import '../model/result_model.dart' as ResultModel;
import '../model/entry_model.dart' as EntryModel;
import '../repository/form_repository.dart';
import '../repository/file_repository.dart';
import '../repository/db_repository.dart';

final formRepositoryProvider = Provider<FormRepository>((ref) => FormRepositoryImpl());
final dbRepositoryProvider = Provider<DBRepository>((ref) => DBRepositoryImpl());
final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepositoryImpl());

final formStateNotifierProvider = StateNotifierProvider(
  (ref) => FormStateNotifier(ref.watch(formRepositoryProvider)),
);
final resultStateNotifierProvider = StateNotifierProvider<ResultNotifier, List<ResultModel.ResultModel>>((ref)
  => ResultNotifier(
    ref.watch(dbRepositoryProvider)
  ),
);
final entriesStateNotifierProvider = StateNotifierProvider<EntriesStateNotifier, List<EntryModel.EntryModel>>((ref)
  => EntriesStateNotifier(
    ref.watch(dbRepositoryProvider),
    ref.watch(fileRepositoryProvider)
  ),
);
