class EntryModel{
    final String name;
    final String repository_url;
    final String status;
    final String branch;
    final int created_at; // seconds since epoch
    final int level;
    final String game_mode;
    final String predict_weight_path;
    final String competition;
    final String error_message;

    const EntryModel(
        this.name,
        this.repository_url,
        this.status,
        this.branch,
        this.created_at,
        this.level,
        this.game_mode,
        this.predict_weight_path,
        this.competition,
        this.error_message,
    );

    EntryModel.fromJson(dynamic map)
      : name = map['Name'],
        repository_url = map['RepositoryURL'],
        status = map['Status'],
        branch = map['Branch'],
        created_at = map['CreatedAt']*1000,
        level = map['Level'],
        game_mode = map['GameMode'],
        predict_weight_path = map['ValuePredictWeight'] ?? "",
        competition = map['Competition'] ?? "",
        error_message = map['ErrorMessage'] ?? "";
    
     List<String> toCsv() => [
        name,
        repository_url,
        status,
        branch,
        datetimeToString(created_at),
        '$level',
        game_mode,
        competition,
        predict_weight_path,
        error_message
      ];
    
    dynamic getMember(String key){
        var res;
        if (key=="name"){
            res = name;
        } else if (key=="repository_url"){
            res = repository_url;
        } else if (key=="status"){
            res = status;
        } else if (key=="branch"){
            res = branch;
        } else if (key=="created_at"){
            res = created_at;
        } else if (key=="level"){
            res = level;
        } else if (key=="game_mode"){
            res = game_mode;
        } else if (key=="predict_weight_path"){
            res = predict_weight_path;
        } else if (key=="error_message"){
            res = error_message;
        } else {
            res = null;
        }
        print("$key, $res");
        return res;
    }
}

List<String> getHeader()=> [
        'name',
        'repository_url',
        'status',
        'branch',
        'created_at',
        'level',
        'game_mode',
        'predict_weight_path',
        'error_message'
    ];

String datetimeToString(int datetime){
    String _datetime = DateTime.fromMillisecondsSinceEpoch(datetime
    ).toString();
    return _datetime.substring(0, _datetime.length-4);
}

List<EntryModel> getExampleEntryModel() {
  return [
    EntryModel(
      "example",
      "example.com",
      "waiting",
      "",
      0,
      1,
      "",
      "",
      "",
      "",
    )
  ];
}