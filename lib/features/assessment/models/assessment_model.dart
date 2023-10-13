import 'package:cloud_firestore/cloud_firestore.dart';

import '../../courses/models/course_model.dart';
import 'course_assessment_model.dart';

class AssessmentModel {
  String? registerNumber;
  String? id;
  String? courseId;
  String? courseName;
  String? userId;
  String? userName;
  List<QuestionModel>? questions;
  bool? isPassed;
  bool? reTake;
  Timestamp? createdAt;
  int? totalQuestions;
  int? attemptsQuestion;
  CourseAssessmentModel? assessmentDteails;
  List<LessonModel>? courseLessons;
  int? totalAttempts;
  bool? isSubmitted;
  AssessmentModel({
    this.registerNumber,
    this.id,
    this.courseId,
    this.courseName,
    this.userId,
    this.userName,
    this.questions,
    this.isPassed,
    this.reTake,
    this.createdAt,
    this.totalQuestions,
    this.attemptsQuestion,
    this.assessmentDteails,
    this.courseLessons,
    this.totalAttempts,
    this.isSubmitted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registerNumber': registerNumber,
      'id': id,
      'courseId': courseId,
      'courseName': courseName,
      'userId': userId,
      'userName': userName,
      'questions': questions?.map((x) => x.toMap()).toList(),
      'isPassed': isPassed,
      'reTake': reTake,
      'createdAt': createdAt,
      'totalQuestions': totalQuestions,
      'attemptsQuestion': attemptsQuestion,
      'assessmentDteails': assessmentDteails?.toMap(),
      'courseLessons': courseLessons?.map((x) => x.toMap()).toList(),
      'totalAttempts': totalAttempts,
      'isSubmitted': isSubmitted,
    };
  }

  factory AssessmentModel.fromMap(Map<String, dynamic> map) {
    return AssessmentModel(
      registerNumber: map['registerNumber'] != null
          ? map['registerNumber'] as String
          : null,
      id: map['id'] != null ? map['id'] as String : null,
      courseId: map['courseId'] != null ? map['courseId'] as String : null,
      courseName:
          map['courseName'] != null ? map['courseName'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      questions: map['questions'] != null
          ? List<QuestionModel>.from(
              (map['questions'] as List<dynamic>).map<QuestionModel?>(
                (x) => QuestionModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      isPassed: map['isPassed'] != null ? map['isPassed'] as bool : null,
      reTake: map['reTake'] != null ? map['reTake'] as bool : null,
      createdAt: map['createdAt'],
      totalQuestions:
          map['totalQuestions'] != null ? map['totalQuestions'] as int : null,
      attemptsQuestion: map['attemptsQuestion'] != null
          ? map['attemptsQuestion'] as int
          : null,
      assessmentDteails:
          CourseAssessmentModel.fromMap(map['assessmentDteails']),
      courseLessons: map['courseLessons']
          .map<LessonModel>((x) => LessonModel.fromMap(x))
          .toList(),
      isSubmitted:
          map['isSubmitted'] != null ? map['isSubmitted'] as bool : null,
      totalAttempts:
          map['totalAttempts'] != null ? map['totalAttempts'] as int : null,
    );
  }

  AssessmentModel copyWith({
    String? id,
    String? courseId,
    String? courseName,
    String? userId,
    String? userName,
    List<QuestionModel>? questions,
    bool? isPassed,
    bool? reTake,
    Timestamp? createdAt,
    int? totalQuestions,
    int? attemptsQuestion,
    CourseAssessmentModel? assessmentDteails,
    String? registerNumber,
    List<LessonModel>? courseLessons,
    int? totalAttempts,
    bool? isSubmitted,
  }) {
    return AssessmentModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      questions: questions ?? this.questions,
      isPassed: isPassed ?? this.isPassed,
      reTake: reTake ?? this.reTake,
      createdAt: createdAt ?? this.createdAt,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      attemptsQuestion: attemptsQuestion ?? this.attemptsQuestion,
      assessmentDteails: assessmentDteails ?? this.assessmentDteails,
      registerNumber: registerNumber ?? this.registerNumber,
      courseLessons: courseLessons ?? this.courseLessons,
      totalAttempts: totalAttempts ?? this.totalAttempts,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
