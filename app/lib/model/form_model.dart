import 'score_evaluation_message.pb.dart';
import '../error.dart' as Errors;
import 'package:fixnum/fixnum.dart' as $fixnum;

class FormModel {
  final String user_name;
  final String repository_URL;
  final String branch_name;
  final int drop_interval;
  final int level;
  final String game_mode;
  final int game_time;
  final int timeout;
  final String predict_weight_path;
  final int trial_num;
  final Iterable<$fixnum.Int64> random_seeds;
  RegExpMatch get _reg_exp_match {
    String _pattern = r'https://github.com/(\S+)/(\S+)$';
    RegExpMatch? _match = RegExp(_pattern).firstMatch(repository_URL);
    if (_match==null){
      throw Errors.RepositoryURLRegexException(repository_URL, _pattern);
    }
    return _match;
  }
  String get github_user_name => _reg_exp_match.group(1)!; // cannot be null because the regex pattern in _reg_exp_match getter
  String get github_repository_name => _reg_exp_match.group(2)!; // cannot be null because the regex pattern in _reg_exp_match getter

  FormModel(
    this.user_name, 
    this.repository_URL, 
    this.branch_name,
    this.drop_interval,
    this.level,
    this.game_mode,
    this.game_time,
    this.timeout,
    this.predict_weight_path,
    this.trial_num,
    this.random_seeds,
  );

  ScoreEvaluationMessage toProtobufMsg(){
    ScoreEvaluationMessage msg = ScoreEvaluationMessage();
    msg.name = this.user_name;
    msg.repositoryUrl = this.repository_URL;
    msg.branch = this.branch_name;
    msg.dropInterval = this.drop_interval;
    msg.level = ScoreEvaluationMessage_GameLevel.values[this.level];
    msg.gameMode = this.game_mode;
    msg.gameTime = this.game_time;
    msg.timeout = this.timeout;
    msg.predictWeightPath = this.predict_weight_path;
    msg.trialNum = this.trial_num;
    msg.randomSeeds..clear()..addAll(this.random_seeds); // repeated field doesn't have setter
    return msg;
  }
}
