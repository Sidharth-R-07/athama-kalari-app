import 'package:cloud_firestore/cloud_firestore.dart';

import '../../assessment/models/course_assessment_model.dart';
import '../../sub_category/models/sub_category_model.dart';

class CourseModel {
  String? id;
  String? title;
  String? videoLink;
  num? courseFee;
  List<dynamic>? bulletPoints;
  String? aboutCourse;
  List<LessonModel>? lessons;
  SubCategoryModel? subCategory;
  List<dynamic>? keywords;
  Timestamp? createdAt;
  List<QuestionModel>? questions;
  CourseAssessmentModel? assessemntDatails;
  CourseModel({
    this.id,
    this.title,
    this.videoLink,
    this.courseFee,
    this.bulletPoints,
    this.aboutCourse,
    this.lessons,
    this.subCategory,
    this.keywords,
    this.createdAt,
    this.questions,
    this.assessemntDatails,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'videoLink': videoLink,
      'courseFee': courseFee,
      'bulletPoints': bulletPoints,
      'aboutCourse': aboutCourse,
      'lessons': lessons?.map((x) => x.toMap()).toList(),
      'subCategory': subCategory?.toMap(),
      'keywords': keywords,
      'createdAt': createdAt,
      'questions': questions?.map((x) => x.toMap()).toList() ?? [],
      'assessemntDatails': assessemntDatails?.toMap(),
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      videoLink: map['videoLink'] != null ? map['videoLink'] as String : null,
      courseFee: map['courseFee'] != null ? map['courseFee'] as num : null,
      bulletPoints: map['bulletPoints'] != null
          ? List<dynamic>.from((map['bulletPoints'] as List<dynamic>))
          : null,
      aboutCourse:
          map['aboutCourse'] != null ? map['aboutCourse'] as String : null,
      lessons: map['lessons'] != null
          ? List<LessonModel>.from(
              (map['lessons']).map<LessonModel?>(
                (x) => LessonModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      subCategory: map['subCategory'] != null
          ? SubCategoryModel.fromMap(map['subCategory'] as Map<String, dynamic>)
          : null,
      keywords: map['keywords'],
      createdAt: map['createdAt'] != null
          ? map['createdAt'] as Timestamp
          : Timestamp.now(),
      questions: map['questions'] != null
          ? List<QuestionModel>.from(
              (map['questions']).map<QuestionModel?>(
                (x) => QuestionModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      assessemntDatails: map['assessmentDetails'] != null
          ? CourseAssessmentModel.fromMap(
              map['assessmentDetails'] as Map<String, dynamic>)
          : null,
    );
  }

  CourseModel copyWith({
    String? id,
    String? title,
    String? videoLink,
    num? courseFee,
    List<dynamic>? bulletPoints,
    String? aboutCourse,
    List<LessonModel>? lessons,
    SubCategoryModel? subCategory,
    List<dynamic>? keywords,
    Timestamp? createdAt,
    List<QuestionModel>? questions,
    CourseAssessmentModel? assessemntDatails,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      videoLink: videoLink ?? this.videoLink,
      courseFee: courseFee ?? this.courseFee,
      bulletPoints: bulletPoints ?? this.bulletPoints,
      aboutCourse: aboutCourse ?? this.aboutCourse,
      lessons: lessons ?? this.lessons,
      subCategory: subCategory ?? this.subCategory,
      keywords: keywords ?? this.keywords,
      createdAt: createdAt ?? this.createdAt,
      questions: questions ?? this.questions,
      assessemntDatails: assessemntDatails ?? this.assessemntDatails,
    );
  }
}

class LessonModel {
  String? id;
  String? title;
  String? videoLink;
  String? courseId;
  int? index;
  Timestamp? createdAt;
  String? pdfUrl;
  String? pdfPath;
  String? description;
  LessonModel({
    this.id,
    this.title,
    this.videoLink,
    this.courseId,
    this.index,
    this.createdAt,
    this.pdfUrl,
    this.pdfPath,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'videoLink': videoLink,
      'courseId': courseId,
      'index': index,
      'createdAt': createdAt,
      'pdfUrl': pdfUrl,
      'pdfPath': pdfPath,
      'description': description,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      videoLink: map['videoLink'] != null ? map['videoLink'] as String : null,
      courseId: map['courseId'] != null ? map['courseId'] as String : null,
      index: map['index'] != null ? map['index'] as int : null,
      createdAt: map['createdAt'] != null
          ? map['createdAt'] as Timestamp
          : Timestamp.now(),
      pdfUrl: map['pdfUrl'] != null ? map['pdfUrl'] as String : null,
      pdfPath: map['pdfPath'] != null ? map['pdfPath'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  LessonModel copyWith({
    String? id,
    String? title,
    String? videoLink,
    String? courseId,
    int? index,
    Timestamp? createdAt,
    String? pdfUrl,
    String? pdfPath,
    String? description,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      videoLink: videoLink ?? this.videoLink,
      courseId: courseId ?? this.courseId,
      index: index ?? this.index,
      createdAt: createdAt ?? this.createdAt,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      pdfPath: pdfPath ?? this.pdfPath,
      description: description ?? this.description,
    );
  }
}

class QuestionModel {
  String? id;
  String? question;
  Timestamp? createdAt;
  String? answer;
  bool? isCorrect;

  QuestionModel({
    this.id,
    this.question,
    this.createdAt,
    this.answer,
    this.isCorrect,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'createdAt': createdAt,
      'answer': answer,
      'isCorrect': isCorrect,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] != null ? map['id'] as String : null,
      question: map['question'] != null ? map['question'] as String : null,
      createdAt: map['createdAt'] != null
          ? map['createdAt'] as Timestamp
          : Timestamp.now(),
      answer: map['answer'] != null ? map['answer'] as String : null,
      isCorrect: map['isCorrect'] != null ? map['isCorrect'] as bool : null,
    );
  }

  QuestionModel copyWith({
    String? id,
    String? question,
    Timestamp? createdAt,
    String? answer,
    bool? isCorrect,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      createdAt: createdAt ?? this.createdAt,
      answer: answer ?? this.answer,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
