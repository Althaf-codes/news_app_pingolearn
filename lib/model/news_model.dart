import 'dart:convert';

class NewsModel {
  final String? author;
  final Source? source;
  final String? title;
  final String? description;
  final String? articleLink;
  final String? imageUrl;
  final DateTime publishedAt;
  final String? content;

  NewsModel({
    required this.author,
    required this.source,
    required this.title,
    required this.description,
    required this.articleLink,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  NewsModel copyWith({
    String? author,
    Source? source,
    String? title,
    String? description,
    String? articleLink,
    String? imageUrl,
    DateTime? publishedAt,
    String? content,
  }) =>
      NewsModel(
        author: author ?? this.author,
        source: source ?? this.source,
        title: title ?? this.title,
        description: description ?? this.description,
        articleLink: articleLink ?? this.articleLink,
        imageUrl: imageUrl ?? this.imageUrl,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  factory NewsModel.fromJson(String str) => NewsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        author: json["author"] ?? '',
        source: Source.fromMap(json["source"]),
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        articleLink: json["url"] ?? '',
        imageUrl: json["urlToImage"] ?? '',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "author": author,
        "source": source?.toMap(),
        "title": title,
        "description": description,
        "articleLink": articleLink,
        "imageUrl": imageUrl,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  Source copyWith({
    String? id,
    String? name,
  }) =>
      Source(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Source.fromMap(Map<String, dynamic> json) => Source(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
