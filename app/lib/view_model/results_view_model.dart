import 'package:state_notifier/state_notifier.dart';

import '../model/result_model.dart';

class ResultNotifier extends StateNotifier<List<ResultModel>> {
  ResultNotifier() : super([
    ResultModel("https://github.com/seigot/tetris", 1665154184, 1020),
    ResultModel("https://github.com/seigot/tetris", 1665154004, 1230)
   ]
   );
}