class UserModel{
    final String id;
    final String name;
    // final String repository_url;

    const UserModel(
        this.id,
        this.name,
        // this.repository_url,
    );
      
    // get github_user_name => repository_url.split("/")[3] ?? "TetrisChallenge";
}
