import 'utils.dart' as Utils;

class NewsModel{
    final String id;
    final String title;
    final int created_at; // seconds since epoch
    final String link_url;
    final String body;

    NewsModel(
        this.id,
        this.title,
        this.created_at,
        this.link_url,
        this.body
    );

    get created_at_string => Utils.datetimeToDateString(created_at);

    
    NewsModel.fromJson(dynamic map)
      : id = map['Id'],
        title = map['Title'] ?? "",
        link_url = map['LinkURL'] ?? "",
        created_at = map['CreatedAt']*1000,
        body = map['body'] ?? "";    
}

