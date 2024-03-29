import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;

import 'form_view_model.dart' as FormViewModel;
import 'results_table_view_model.dart' as ResultsTableViewModel;
import 'entries_view_model.dart' as EntriesViewModel;
import 'random_seeds_form_view_model.dart' as RandomSeedsFormViewModel;
import 'result_detail_view_model.dart' as ResultDetailViewModel;
import 'interrupt_evaluation_view_model.dart' as InterruptionEvaluationViewModel;
import 'news_view_model.dart' as NewsViewModel;
import 'news_detail_view_model.dart' as NewsDetailViewModel;
import 'training_form_view_model.dart' as TrainingFormViewModel;
import 'training_list_view_model.dart' as TrainingListViewModel;

import '../model/result_model.dart' as ResultModel;
import '../model/entry_model.dart' as EntryModel;
import '../model/results_table_model.dart' as ResultsTableModel;
import '../model/news_model.dart' as NewsModel;
import '../model/training_form_model.dart' as TrainingFormModel;
import '../repository/form_repository.dart';
import '../repository/file_repository.dart';
import '../repository/db_repository.dart';

final formRepositoryProvider = Provider<FormRepository>((ref) => FormRepositoryImpl());
final dbRepositoryProvider = Provider<DBRepository>((ref) => DBRepositoryImpl());
final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepositoryImpl());

final formStateNotifierProvider = StateNotifierProvider(
  (ref) => FormViewModel.FormStateNotifier(ref.watch(formRepositoryProvider)),
);
final resultsTableStateNotifierProvider = StateNotifierProvider.family<ResultsTableViewModel.ResultsTableStateNotifier, ResultsTableModel.ResultsTableModel, String>(
  (ref, competition) => ResultsTableViewModel.ResultsTableStateNotifier(ref.watch(dbRepositoryProvider), competition),
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

final evaluationInterruptionStateNotifierProvider = StateNotifierProvider.autoDispose.family<InterruptionEvaluationViewModel.InterruptionButtonStateNotifier, InterruptionEvaluationViewModel.InterruptionButtonState, ResultModel.ResultModel>(
  (ref, result) => InterruptionEvaluationViewModel.InterruptionButtonStateNotifier(ref.watch(dbRepositoryProvider), result),
);

final newsStateNotifierProvider = StateNotifierProvider<NewsViewModel.NewsStateNotifier, List<NewsModel.NewsModel>>(
  (ref) => NewsViewModel.NewsStateNotifier(ref.watch(dbRepositoryProvider)),
);

final newsDetailStateNotifierProvider = StateNotifierProvider.autoDispose.family<NewsDetailViewModel.NewsDetailStateNotifier, NewsModel.NewsModel?, String>(
  (ref, id) => NewsDetailViewModel.NewsDetailStateNotifier(ref.watch(dbRepositoryProvider), id),
);

final trainingFormStateNotifierProvider = StateNotifierProvider.autoDispose.family<TrainingFormViewModel.TrainingFormStateNotifier, TrainingFormModel.TrainingFormModel, TrainingFormModel.TrainingModel>(
  (ref, training) => TrainingFormViewModel.TrainingFormStateNotifier(ref.watch(formRepositoryProvider), ref.watch(dbRepositoryProvider), training),
);

final trainingListStateNotifierProvider = StateNotifierProvider.autoDispose.family<TrainingListViewModel.TrainingListStateNotifier, List<TrainingFormModel.TrainingModel>, String>(
  (ref, section) => TrainingListViewModel.TrainingListStateNotifier(ref.watch(dbRepositoryProvider), section),
);
