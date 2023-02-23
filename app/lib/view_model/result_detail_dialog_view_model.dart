import 'package:state_notifier/state_notifier.dart';

import '../model/result_model.dart' as ResultModel;


class SelectedResultStateNotifier extends StateNotifier<ResultModel.ResultModel> {
  SelectedResultStateNotifier() : super(ResultModel.getExampleResultModel()){
  }
  void selectResult(ResultModel.ResultModel _result) {
    state = _result;
  }
}