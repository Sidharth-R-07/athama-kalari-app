// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionCourseModel {
  String? registerNumber;

  String? userId;
  Timestamp? createdAt;
  DateTime? date;
  CourseModel? mycourse;
  SubscriptionCourseModel({
    this.mycourse,
    this.userId,
    this.createdAt,
    this.registerNumber,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mycourse': mycourse?.toMap(),
      'userId': userId,
      'createdAt': createdAt,
      'registerNumber': registerNumber,
      'date': date ?? DateTime.now(),
    };
  }

  factory SubscriptionCourseModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionCourseModel(
      mycourse: map['mycourse'] != null
          ? CourseModel.fromMap(map['mycourse'] as Map<String, dynamic>)
          : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      createdAt: map['createdAt'],
      registerNumber: map['registerNumber'] != null
          ? map['registerNumber'] as String
          : null,
      date: map['date'] != null ? map['date'].toDate() as DateTime : null,
    );
  }

  SubscriptionCourseModel copyWith({
    String? courseId,
    String? userId,
    Timestamp? createdAt,
    String? registerNumber,
    DateTime? date,
    CourseModel? course,
  }) {
    return SubscriptionCourseModel(
      mycourse: course ?? this.mycourse,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      registerNumber: registerNumber ?? this.registerNumber,
      date: date ?? this.date,
    );
  }
}
