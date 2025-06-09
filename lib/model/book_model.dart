import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookModel {
  final int? id;
  final String title;
  final String author;
  final String description;
  final String genre;
  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'genre': genre,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      author: map['author'] as String,
      description: map['description'] as String,
      genre: map['genre'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
