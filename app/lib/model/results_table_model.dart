import 'result_model.dart' as ResultModel;

class ResultsTableModel{
  final List<ResultModel.ResultModel> results;
  final bool is_before_page_enabled;
  final bool is_next_page_enabled;

  ResultsTableModel(
    this.results,
    this.is_before_page_enabled,
    this.is_next_page_enabled,
  );
}