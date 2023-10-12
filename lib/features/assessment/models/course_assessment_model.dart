class CourseAssessmentModel {
  num? totalMarks;
  int? questionsCount;
  num? duration;
  CourseAssessmentModel({
    this.totalMarks,
    this.questionsCount,
    this.duration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalMarks': totalMarks,
      'questionsCount': questionsCount,
      'duration': duration,
    };
  }

  factory CourseAssessmentModel.fromMap(Map<String, dynamic> map) {
    return CourseAssessmentModel(
      totalMarks: map['totalMarks'] != null ? map['totalMarks'] as num : null,
      questionsCount:
          map['questionsCount'] != null ? map['questionsCount'] as int : null,
      duration: map['duration'] != null ? map['duration'] as num : null,
    );
  }
}
