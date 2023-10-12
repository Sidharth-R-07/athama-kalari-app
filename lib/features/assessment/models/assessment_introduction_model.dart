// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class AssessmentIntroductionModel {
  String? id;
  String? videoUrl;
  List<String>? termsAndConditions;
  String? about;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  num? dutation;
  AssessmentIntroductionModel({
    this.id,
    this.videoUrl,
    this.termsAndConditions,
    this.about,
    this.createdAt,
    this.updatedAt,
    this.dutation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'videoUrl': videoUrl,
      'termsAndConditions': termsAndConditions,
      'about': about,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'dutation': dutation,
    };
  }

  factory AssessmentIntroductionModel.fromMap(Map<String, dynamic> map) {
    return AssessmentIntroductionModel(
      id: map['id'] != null ? map['id'] as String : null,
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
      termsAndConditions:
          map['termsAndConditions'].map<String>((e) => e.toString()).toList(),
      about: map['about'] != null ? map['about'] as String : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      dutation: map['dutation'] != null ? map['dutation'] as num : null,
    );
  }

  AssessmentIntroductionModel copyWith({
    String? id,
    String? videoUrl,
    List<String>? termsAndConditions,
    String? about,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    num? dutation,
  }) {
    return AssessmentIntroductionModel(
      id: id ?? this.id,
      videoUrl: videoUrl ?? this.videoUrl,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      about: about ?? this.about,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dutation: dutation ?? this.dutation,
    );
  }
}
