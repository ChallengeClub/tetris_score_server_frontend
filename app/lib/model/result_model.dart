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