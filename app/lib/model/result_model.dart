class ResultModel{
    final String repository_url;
    final int created_at;
    final num mean_score;

    ResultModel(
        this.repository_url,
        this.created_at,
        this.mean_score
    );
}