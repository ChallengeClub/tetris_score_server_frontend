import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'form_view_model.dart' as FormViewModel;
import 'results_view_model.dart' as ResultsViewModel;
import 'entries_view_model.dart' as EntriesViewModel;
import '../model/result_model.dart' as ResultModel;
import '../model/entry_model.dart' as EntryModel;
import '../repository/form_repository.dart';
import '../repository/file_repository.dart';
import '../repository/db_repository.dart';

final formRepositoryProvider = Provider<FormRepository>((ref) => FormRepositoryImpl());
final dbRepositoryProvider = Provider<DBRepository>((ref) => DBRepositoryImpl());
final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepositoryImpl());

final formStateNotifierProvider = StateNotifierProvider(
  (ref) => FormViewModel.FormStateNotifier(ref.watch(formRepositoryProvider)),
);
final resultsStateNotifierProvider = StateNotifierProvider<ResultsViewModel.ResultsStateNotifier, List<ResultModel.ResultModel>>((ref)
  => ResultsViewModel.ResultsStateNotifier(
    ref.watch(dbRepositoryProvider)
  ),
);
final entriesStateNotifierProvider = StateNotifierProvider<EntriesViewModel.EntriesStateNotifier, List<EntryModel.EntryModel>>((ref)
  => EntriesViewModel.EntriesStateNotifier(
    ref.watch(dbRepositoryProvider),
    ref.watch(fileRepositoryProvider)
  ),
);
