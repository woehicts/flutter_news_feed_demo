
class FeedItem {
  /// The title of an article
  final String title;
  /// The author of an article
  final String author;
  /// Summary of an article, json[["articles"]][["description"]]
  final String shortDescription;
  /// An excerpt from the content of an article
  final String longDescription;
  /// The URL address of the original page of an article
  final String articleAddress;
  /// The URL string of an editorial figure of an article
  final String articleFigureURL;
  /// Time an article was first published on the Web.
  final DateTime? timePublished;

  /// [title] - title of an article<br/>
  /// [author] - author of an article <br/>
  /// [shortDescription] - summary of an article, json[["articles"]][["description"]] <br/>
  /// [longDescription] - excerpt from the content of an article <br/>
  /// [articleAddress] - URL address of the original page of an article <br/>
  /// [timePublished] - time an article was first published on the Web. <br/>
  /// [articleFigureURL] - URL string of an editorial figure of an article
  const FeedItem({
    required this.title,
    required this.author,
    required this.shortDescription,
    required this.longDescription,
    required this.articleAddress,
    required this.timePublished,
    required this.articleFigureURL
});
  /// Builds [FeedItem] using an entry from a [json] Map object. <br/>
  /// The successful server text response should first be read by a JSON decoder,
  /// then this factory method should be applied on the
  /// separate feed entries (i.e. list from json[['articles'_]] ) of the decoded object.
  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      title: json['title'] ?? "",
      author: json['author'] ?? "",
      shortDescription: json['description'] ?? "",
      articleAddress: json['url'] ?? "",
      articleFigureURL: json['urlToImage'] ?? "",
      longDescription: json['content'] ?? "",
      timePublished: DateTime.tryParse(json['publishedAt'])
    );
  }
}