import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/model/news_model.dart';

class UserModel {
  final String name;
  final List<String> preference;
  final String country;
  final String email;
  final List<NewsModel> bookmarks;

  UserModel({
    required this.name,
    required this.preference,
    required this.country,
    required this.email,
    required this.bookmarks,
  });

  UserModel copyWith({
    String? name,
    List<String>? preference,
    String? country,
    String? email,
    List<NewsModel>? bookmarks,
  }) =>
      UserModel(
        name: name ?? this.name,
        preference: preference ?? this.preference,
        country: country ?? this.country,
        email: email ?? this.email,
        bookmarks: bookmarks ?? this.bookmarks,
      );

  static final empty = UserModel(
      name: '', preference: [], country: '', email: '', bookmarks: []);

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        preference: List<String>.from(json["preference"].map((x) => x)),
        country: json["country"],
        email: json["email"],
        bookmarks: List<NewsModel>.from(
            json["bookmarks"].map((x) => NewsModel.fromMap(x))),
      );

  factory UserModel.fromDocument(DocumentSnapshot data) {
    Map json = data.data() as Map;

    return UserModel(
      name: json["name"],
      preference: List<String>.from(json["preference"].map((x) => x)),
      country: json["country"],
      email: json["email"],
      bookmarks: List<NewsModel>.from(
          json["bookmarks"].map((x) => NewsModel.fromMap(x))),
    );
  }
  Map<String, dynamic> toMap() => {
        "name": name,
        "preference": List<String>.from(preference.map((x) => x)),
        "country": country,
        "email": email,
        "bookmarks": List<NewsModel>.from(bookmarks.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return "The user is $name , $country, $email";
  }
}
