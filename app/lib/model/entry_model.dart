class EntryModel{
    final String name;
    final String repository_url;
    final String status;
    final String branch;
    final int created_at; // seconds since epoch
    final int level;
    final String game_mode;
    final String predict_weight_path;
    final String error_message;

    EntryModel(
        this.name,
        this.repository_url,
        this.status,
        this.branch,
        this.created_at,
        this.level,
        this.game_mode,
        this.predict_weight_path,
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
        error_message = map['ErrorMessage'] ?? "";
    
     List<String> toCsv() => [
        name,
        repository_url,
        status,
        branch,
        datetimeToString(created_at),
        '$level',
        game_mode,
        predict_weight_path,
        error_message
      ];
}

List<String> getHeader()=>[
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