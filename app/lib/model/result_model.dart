class ResultModel{
    final String repository_url;
    final String status;
    final String branch;
    final int created_at; // seconds since epoch
    final num mean_score;

    ResultModel(
        this.repository_url,
        this.status,
        this.branch,
        this.created_at,
        this.mean_score
    );
    
    ResultModel.fromJson(dynamic map)
      : repository_url = map['RepositoryURL'],
        status = map['Status'],
        branch = map['Branch'],
        created_at = map['CreatedAt']*1000,
        mean_score = map['MeanScore'];
}

List<String> getResultColumns(){
    return [
        "createdAt",
        "status",
        "repository_url",
        "branch",
        "mean_score"
    ];
}