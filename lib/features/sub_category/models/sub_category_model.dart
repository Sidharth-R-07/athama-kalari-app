// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../category/models/category_model.dart';

class SubCategoryModel {
  final String? id;
  final String? title;
  final String? image;
  final Timestamp? createdAt;
  List<String>? courses;
  final int? lessons;
  final List<dynamic>? keywords;
  final CategoryModel? categoryModel;

  SubCategoryModel({
    this.id,
    this.title,
    this.image,
    this.createdAt,
    this.courses,
    this.lessons,
    this.keywords,
    this.categoryModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'createdAt': createdAt,
      'courses': courses,
      'lessons': lessons,
      'keywords': keywords,
      'categoryModel': categoryModel?.toMap(),
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['createdAt'],
      courses: map['courses'] != null
          ? List<String>.from((map['courses'] as List<dynamic>).map<String>(
              (dynamic x) => x as String,
            ))
          : null,
      lessons: map['lessons'] != null ? map['lessons'] as int : null,
      keywords: map['keywords'],
      categoryModel: map['categoryModel'] != null
          ? CategoryModel.fromMap(map['categoryModel'] as Map<String, dynamic>)
          : null,
    );
  }

  SubCategoryModel copyWith({
    String? id,
    String? title,
    String? image,
    Timestamp? createdAt,
    List<String>? courses,
    int? lessons,
    List<dynamic>? keywords,
    CategoryModel? categoryModel,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      courses: courses ?? this.courses,
      lessons: lessons ?? this.lessons,
      keywords: keywords ?? this.keywords,
      categoryModel: categoryModel ?? this.categoryModel,
    );
  }
}
