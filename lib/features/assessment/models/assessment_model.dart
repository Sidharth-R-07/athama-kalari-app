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
  List<String>? attemptsQuestion;
  CourseAssessmentModel? assessmentDteails;
  List<LessonModel>? courseLessons;
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
      'courseLessons': courseLessons,
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
                (map['questions'] as List<int>).map<QuestionModel?>(
                  (x) => QuestionModel.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        isPassed: map['isPassed'] != null ? map['isPassed'] as bool : null,
        reTake: map['reTake'] != null ? map['reTake'] as bool : null,
        createdAt: map['createdAt'],
        totalQuestions:
            map['totalQuestions'] != null ? map['totalQuestions'] as int : null,
        attemptsQuestion:
            map['attemptsQuestion'].map<String>((x) => x as String).toList(),
        assessmentDteails: map['assessmentDteails'] != null
            ? CourseAssessmentModel.fromMap(
                map['assessmentDteails'] as Map<String, dynamic>)
            : null,
        courseLessons:
            map['courseLessons'].map<String>((x) => x as String).toList());
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
    List<String>? attemptsQuestion,
    CourseAssessmentModel? assessmentDteails,
    String? registerNumber,
    List<LessonModel>? courseLessons,
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
    );
  }
}
