import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
  final String? title;
  final String? image;
  final Timestamp? createdAt;
  final List<dynamic>? groups;
  List<String>? courses;
  final int? lessons;
  final List<dynamic>? keywords;

  CategoryModel({
    this.id,
    this.title,
    this.image,
    this.createdAt,
    this.groups,
    this.courses,
    this.lessons,
    this.keywords,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'createdAt': createdAt,
      'groups': groups,
      'courses': courses,
      'lessons': lessons,
      'keywords': keywords,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['createdAt'],
      groups: map['groups'],
      courses: map['courses'] != null
          ? List<String>.from((map['courses'] as List<dynamic>).map<String>(
              (dynamic x) => x as String,
            ))
          : null,
      lessons: map['lessons'] != null ? map['lessons'] as int : null,
      keywords: map['keywords'],
    );
  }

  CategoryModel copyWith({
    String? id,
    String? title,
    String? image,
    Timestamp? createdAt,
    List<String>? groups,
    List<String>? courses,
    int? lessons,
    List<String>? keyword,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      groups: groups ?? this.groups,
      courses: courses ?? this.courses,
      lessons: lessons ?? this.lessons,
      keywords: keywords ?? this.keywords,
    );
  }
}
