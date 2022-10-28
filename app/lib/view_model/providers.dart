import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'form_state_notifier.dart';
import 'results_view_model.dart';
import '../model/result_model.dart';
import '../repository/form_repository.dart';
import '../repository/db_repository.dart';

final formRepositoryProvider = Provider<FormRepository>((ref) => FormRepositoryImpl());
final dbRepositoryProvider = Provider<DBRepository>((ref) => DBRepositoryImpl());
final formStateNotifierProvider = StateNotifierProvider(
  (ref) => FormStateNotifier(ref.watch(formRepositoryProvider)),
);
final resultStateNotifierProvider = StateNotifierProvider<ResultNotifier, List<ResultModel>>((ref)
  => ResultNotifier(ref.watch(dbRepositoryProvider)),
);