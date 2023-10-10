import 'package:cloud_firestore/cloud_firestore.dart';

import '../../courses/models/course_model.dart';

class BannerModel {
  String? id;
  String? image;
  CourseModel? course;
  Timestamp? createdAt;
  BannerModel({
    this.id,
    this.image,
    this.course,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'course': course?.toMap(),
      'createdAt': createdAt,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      course: map['course'] != null
          ? CourseModel.fromMap(map['course'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'],
    );
  }

  BannerModel copyWith({
    String? id,
    String? image,
    CourseModel? course,
    Timestamp? createdAt,
  }) {
    return BannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      course: course ?? this.course,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
