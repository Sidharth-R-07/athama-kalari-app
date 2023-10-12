import 'dart:developer';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/assessment_introduction_model.dart';

class AssessmentProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  List<AssessmentModel> myAssessment = [];

  AssessmentIntroductionModel? getIntroduction;

  bool initailLoading = false;

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
      log("ERROR IN FETCH INNTRODUCTION$e");
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
      log("ASSESSMENT ADDED SUCCESSFULLY");
    } catch (e) {
      log("ERROR IN ADD NEW ASSESSMENT$e");
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
      log("MY ASSESSMENTS FETCHED SUCCESSFULLY");
    } catch (e) {
      log("ERROR IN FETCH MY ASSESSMENTS$e");
    }
  }
}
