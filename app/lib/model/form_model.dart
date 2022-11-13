import 'score_evaluation_message.pb.dart';

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
    this.trial_num
  );

  ScoreEvaluationMessage toProtobufMsg(){
    ScoreEvaluationMessage msg = ScoreEvaluationMessage();
    msg.repositoryUrl = this.repository_URL;
    msg.branch = this.branch_name;
    msg.dropInterval = this.drop_interval;
    msg.level = ScoreEvaluationMessage_GameLevel.EASY;
    msg.gameMode = this.game_mode;
    msg.gameTime = this.game_time;
    msg.timeout = this.timeout;
    msg.predictWeightPath = this.predict_weight_path;
    msg.trialNum = this.trial_num;
    return msg;
  }
}
