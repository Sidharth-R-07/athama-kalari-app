import 'dart:async';
import 'dart:math';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/assessment_introduction_model.dart';

class AssessmentProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  List<AssessmentModel> myAssessment = [];

  AssessmentIntroductionModel? getIntroduction;

  bool addAssessmentLoading = false;

  bool initailLoading = false;

  int currentQuestionIndex = 0;

  QuestionModel? currentQuestion;
  List<QuestionModel> questions = [];

  //GET ASSESSMENT INTRODUCTION
  Future<void> getAssessmentIntroduction() async {
    initailLoading = true;
    notifyListeners();
    try {
      final doc =
          await firestore.collection('assessmentIntroduction').doc("1").get();
      getIntroduction = AssessmentIntroductionModel.fromMap(doc.data()!);

      initailLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("ERROR IN FETCH INNTRODUCTION$e");
      initailLoading = false;
      notifyListeners();
    }
  }

  //ADD NEW ASSESSMENT IN COLLECTION
  Future<void> addNewAssessment(AssessmentModel assessment) async {
    try {
      final id = firestore.collection('assessment').doc().id;

      assessment.id = id;

      await firestore
          .collection('assessment')
          .doc(assessment.id)
          .set(assessment.toMap());
      debugPrint("ASSESSMENT ADDED SUCCESSFULLY");
    } catch (e) {
      debugPrint("ERROR IN ADD NEW ASSESSMENT$e");
    }
  }

  //FETCH MY ASSESSMENTS
  Future<void> fetchMyAssessment() async {
    try {
      final snapshot = await firestore
          .collection('assessment')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('createdAt', descending: true)
          .get();

      myAssessment =
          snapshot.docs.map((e) => AssessmentModel.fromMap(e.data())).toList();

      notifyListeners();
      debugPrint("MY ASSESSMENTS FETCHED SUCCESSFULLY");
    } catch (e) {
      debugPrint("ERROR IN FETCH MY ASSESSMENTS$e");
    }
  }

  //FETCH ASSESSMENT QUESTION FROM COURSE
  fetchQuestion(String courseId, int questionCount) async {
    try {
      debugPrint("COURSE ID $courseId");
      final snapshot =
          await firestore.collection('courses').doc(courseId).get();

      questions = snapshot
          .data()?['questions']
          .map<QuestionModel>((e) => QuestionModel.fromMap(e))
          .toList();

      debugPrint("MY QUESTIONS FETCHED SUCCESSFULLY");
    } catch (e) {
      debugPrint("ERROR IN FETCH MY ASSESSMENTS$e");

      return null;
    }
  }

  //GET RANDOM QUESTION
  getRandomItems(int count) {
    print("GET getRandomItems QUESTION CALLED");

    final Random random = Random();
    List<QuestionModel> randomItems = [];

    while (randomItems.length < count) {
      final int randomIndex = random.nextInt(questions.length);
      QuestionModel item = questions[randomIndex];

      if (!randomItems.contains(item)) {
        randomItems.add(item);
      }
    }

    questions = randomItems;

    currentQuestion = questions[currentQuestionIndex];
    notifyListeners();

    debugPrint("Random Items: $randomItems");
    return randomItems;
  }

  //QUESTION SECTION

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      currentQuestion = questions[currentQuestionIndex];

      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      currentQuestion = questions[currentQuestionIndex];
      notifyListeners();
    }
  }

  //SUMBMIT ASSESSMENT

  Future<bool> submitAssessment(AssessmentModel assessment) async {
    bool res = false;
    addAssessmentLoading = true;
    notifyListeners();
    try {
      await firestore
          .collection('assessment')
          .doc(assessment.id)
          .update(assessment.toMap());

      debugPrint("ASSESSMENT SUBMITTED SUCCESSFULLY");
      res = true;
    } catch (e) {
      res = false;
      debugPrint("ERROR IN SUBMIT ASSESSMENT$e");
    }
    addAssessmentLoading = false;
    notifyListeners();
    return res;
  }

  void cleardata() {
    currentQuestionIndex = 0;
    currentQuestion = null;
    questions = [];
    notifyListeners();
  }
}
