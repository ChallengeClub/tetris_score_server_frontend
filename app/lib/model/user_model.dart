class UserModel{
    final String id;
    final String name;
    final String repository_url;

    const UserModel(
        this.id,
        this.name,
        this.repository_url,
    );

    UserModel.fromJson(dynamic map)
      : id = map["id"],
        name = map['Name'],
        repository_url = map['RepositoryURL'];
}
