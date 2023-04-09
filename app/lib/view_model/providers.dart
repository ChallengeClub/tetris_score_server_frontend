import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;


import 'form_view_model.dart' as FormViewModel;
import 'results_view_model.dart' as ResultsViewModel;
import 'entries_view_model.dart' as EntriesViewModel;
import 'random_seeds_form_view_model.dart' as RandomSeedsFormViewModel;
import 'result_detail_view_model.dart' as ResultDetailViewModel;
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
final randomSeedsFormStateNotifierProvider = StateNotifierProvider<RandomSeedsFormViewModel.RandomSeedsFormStateNotifier, RandomSeedsFormViewModel.RandomSeedsFormModel>(
  (ref) => RandomSeedsFormViewModel.RandomSeedsFormStateNotifier()
);

final resultDetailStateNotifierProvider = StateNotifierProvider.autoDispose.family<ResultDetailViewModel.ResultDetailStateNotifier, ResultModel.ResultModel?, String>(
  (ref, id) => ResultDetailViewModel.ResultDetailStateNotifier(ref.watch(dbRepositoryProvider), id),
);
