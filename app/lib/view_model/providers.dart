import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'form_state_notifier.dart';
import 'results_view_model.dart';
import 'entry_table_view_model.dart';
import '../model/result_model.dart';
import '../model/entry_table_model.dart';
import '../repository/form_repository.dart';
import '../repository/file_repository.dart';
import '../repository/db_repository.dart';

final formRepositoryProvider = Provider<FormRepository>((ref) => FormRepositoryImpl());
final dbRepositoryProvider = Provider<DBRepository>((ref) => DBRepositoryImpl());
final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepositoryImpl());

final formStateNotifierProvider = StateNotifierProvider(
  (ref) => FormStateNotifier(ref.watch(formRepositoryProvider)),
);
final resultStateNotifierProvider = StateNotifierProvider<ResultNotifier, List<ResultModel>>((ref)
  => ResultNotifier(
    ref.watch(dbRepositoryProvider)
  ),
);
final entryTableStateNotifierProvider = StateNotifierProvider<EntryTableStateNotifier, EntryTable>((ref)
  => EntryTableStateNotifier(
    ref.watch(dbRepositoryProvider),
    ref.watch(fileRepositoryProvider)
  ),
);
