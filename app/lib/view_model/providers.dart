import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'form_state_notifier.dart';
import '../repository/form_repository.dart';

final formRepositoryProvider = Provider<FormRepository>((ref) => FormRepositoryImpl());
final formStateNotifierProvider = StateNotifierProvider(
  (ref) => FormStateNotifier(ref.watch(formRepositoryProvider)),
);