class NewsArticle {
  String id;
  String title;
  String description;
  String url;
  String image;
  DateTime publishedAt;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.image,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      image: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}
