import 'package:state_notifier/state_notifier.dart';

import '../model/result_model.dart';

class ResultNotifier extends StateNotifier<List<ResultModel>> {
  ResultNotifier() : super([
    ResultModel("https://github.com/seigot/tetris", "succeeded", "master", 1665154184000, 1020),
    ResultModel("https://github.com/seigot/tetris", "succeeded", "master", 1665154004000, 1230)
   ]
   );
}