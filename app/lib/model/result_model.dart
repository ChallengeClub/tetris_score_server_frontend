class ResultModel{
    final String repository_url;
    final String status;
    final String branch;
    final int created_at; // seconds since epoch
    final num mean_score;
    final int game_time;
    final int level;
    final String game_mode;
    final String predict_weight_path;
    final int trial_number;
    final num stddev_score;
    final int max_score;
    final int min_score;
    final String error_message;

    ResultModel(
        this.repository_url,
        this.status,
        this.branch,
        this.created_at,
        this.mean_score,
        this.game_time,
        this.level,
        this.game_mode,
        this.predict_weight_path,
        this.trial_number,
        this.stddev_score,
        this.max_score,
        this.min_score,
        this.error_message,
    );
    
    ResultModel.fromJson(dynamic map)
      : repository_url = map['RepositoryURL'],
        status = map['Status'],
        branch = map['Branch'],
        created_at = map['CreatedAt']*1000,
        mean_score = map['MeanScore'],
        game_time = map['GameTime'],
        level = map['Level'],
        game_mode = map['GameMode'],
        predict_weight_path = map['ValuePredictWeight'],
        trial_number = map['TrialNum'],
        stddev_score = map['StdDevScore'],
        max_score = map['MaxScore'],
        min_score = map['MinScore'],
        error_message = map['ErrorMessage'];
}
