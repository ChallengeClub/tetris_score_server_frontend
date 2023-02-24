class ResultModel{
    final String name;
    final String repository_url;
    final String status;
    final String branch;
    final int created_at; // seconds since epoch
    final int? started_at;
    final int? ended_at;
    final num? mean_score;
    final int game_time;
    final int level;
    final String game_mode;
    final String predict_weight_path;
    final int trial_number;
    final num? stddev_score;
    final int? max_score;
    final int? min_score;
    final List<int> random_seeds;
    final List<int> scores;
    final String error_message;
    final List<int> gameover_count;

    ResultModel(
        this.name,
        this.repository_url,
        this.status,
        this.branch,
        this.created_at,
        this.started_at,
        this.ended_at,
        this.mean_score,
        this.game_time,
        this.level,
        this.game_mode,
        this.predict_weight_path,
        this.trial_number,
        this.stddev_score,
        this.max_score,
        this.min_score,
        this.random_seeds,
        this.scores,
        this.error_message,
        this.gameover_count,
    );
    
    ResultModel.fromJson(dynamic map)
      : name = map['Name'],
        repository_url = map['RepositoryURL'],
        status = map['Status'],
        branch = map['Branch'],
        created_at = map['CreatedAt'],
        started_at = map['StartedAt'],
        ended_at = map['EndedAt'],
        mean_score = map['MeanScore'],
        game_time = map['GameTime'],
        level = map['Level'],
        game_mode = map['GameMode'],
        predict_weight_path = map['ValuePredictWeight'],
        trial_number = map['TrialNum'],
        stddev_score = map['StdDevScore'],
        max_score = map['MaxScore'],
        min_score = map['MinScore'],
        random_seeds = fromStringToListInt(map['RandomSeeds']),
        scores = fromStringToListInt(map["Scores"]),
        error_message = map['ErrorMessage'] ?? "",
        gameover_count = fromListDynamicToListInt(map['GameOverCount']);
    
    Map<String, dynamic> toJson() => {
        'name': name,
        'repository_url': repository_url,
        'status': status,
        'branch': branch,
        'created_at': created_at,
        'started_at': started_at,
        'ended_at': ended_at,
        'mean_score': mean_score,
        'game_time': game_time,
        'level': level,
        'game_mode': game_mode,
        'predict_weight_path': predict_weight_path,
        'trial_number': trial_number,
        'stddev_score': stddev_score,
        'max_score': max_score,
        'min_score': min_score,
        'random_seeds': random_seeds,
        "scores": scores,
        'error_message': error_message,
        'gameover_count': gameover_count
    };
    List<String> toCsv() => [
        name,
        repository_url,
        status,
        branch,
        datetimeToString(created_at),
        datetimeToString(started_at),
        datetimeToString(ended_at),
        '$mean_score',
        '$game_time',
        '$level',
        game_mode,
        predict_weight_path,
        '$trial_number',
        '$stddev_score',
        '$max_score',
        '$min_score',
        random_seeds.join(","),
        scores.join(","),
        error_message,
        gameover_count.join(","),
      ];    
}

String datetimeToString(int? datetime){
  String _res = "";
  if (datetime == null){
    return _res;
  }

  String _datetime = DateTime.fromMillisecondsSinceEpoch(datetime*1000
  ).toString();
  _res = _datetime.substring(0, _datetime.length-4);
  return _res;
}

List<int> fromStringToListInt(String? string){
  if ((string == null)||(string == "")){
    return [];
  } else {
    return string.split(',')
                 .map<int>((String value) => int.parse(value))
                 .toList();
  }
}

List<int> fromListDynamicToListInt(List<dynamic>? values){
  if (values==null){
    return [];
  }
  return values.cast<int>();
}
ResultModel getExampleResultModel() {
  return ResultModel(
      "this is example",
      "example.com",
      "waiting",
      "example",
      0,
      1,
      4,
      0,
      0,
      1,
      "default",
      "",
      1,
      0,
      0,
      0,
      [0],
      [0],
      "",
      [],
  );
}