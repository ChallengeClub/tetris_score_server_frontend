class ResultModel{
    final String id;
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
    final List<int> gameover_counts;
    final List<int> block_indices;
    final List<List<int>> line_score_stats;
    final List<List<int>> shape_info_stats;
    
    get github_user_name => repository_url.split("/")[3] ?? "TetrisChallenge";
    get mean_score_string => mean_score!=null ? mean_score!.toStringAsFixed(2) : "";
    get stddev_score_string => stddev_score!=null ?  stddev_score!.toStringAsFixed(2) : "";
    get created_at_string => datetimeToString(created_at);
    get started_at_string => datetimeToString(started_at);
    get ended_at_string => datetimeToString(ended_at);

    ResultModel(
        this.id,
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
        this.gameover_counts,
        this.block_indices,
        this.line_score_stats,
        this.shape_info_stats,
    );
    
    ResultModel.fromJson(dynamic map)
      : id = map['Id'],
        name = map['Name'],
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
        predict_weight_path = map['ValuePredictWeight'] ?? "",
        trial_number = map['TrialNum'],
        stddev_score = map['StdDevScore'],
        max_score = map['MaxScore'],
        min_score = map['MinScore'],
        random_seeds = fromListDynamicToListInt(map['RandomSeeds']),
        scores = fromListDynamicToListInt(map["Scores"]),
        error_message = map['ErrorMessage'] ?? "",
        gameover_counts = fromListDynamicToListInt(map['GameOverCount']),
        block_indices = fromListDynamicToListInt(map['BlockIndex']),
        line_score_stats = fromListListDynamicToListListInt(map['LineScoreStat']),
        shape_info_stats = fromListListDynamicToListListInt(map['ShapeInfoStat']);
    
    Map<String, dynamic> toJson() => {
        'id': id,
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
        'gameover_counts': gameover_counts,
        'block_indices': block_indices,
        'line_score_stat': line_score_stats,
        'shape_info_stat': shape_info_stats,
    };
    List<String> toCsv() => [
        id,
        name,
        repository_url,
        status,
        branch,
        created_at_string,
        started_at_string,
        ended_at_string,
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
        gameover_counts.join(","),
        block_indices.join(","),
        line_score_stats.join(","),
        shape_info_stats.join(","),
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

List<int> fromListDynamicToListInt(List<dynamic>? values){
  if (values==null){
    return [];
  }
  return values.cast<int>();
}

List<List<int>> fromListListDynamicToListListInt(List<dynamic>? lines){
  if (lines==null){
    return [[]];
  }
  List<List<int>> _res = []; 
  for (List<dynamic> _line in lines){
    _res.add(_line.cast<int>());
  }
  return _res;
}

ResultModel getExampleResultModel() {
  return ResultModel(
      "abcdefg",
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
      [0],
      [[0]],
      [[0]],
  );
}