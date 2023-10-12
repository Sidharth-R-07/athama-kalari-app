import 'dart:developer';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:athma_kalari_app/features/assessment/models/course_assessment_model.dart';
import 'package:athma_kalari_app/features/assessment/provider/assessment_provider.dart';
import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:athma_kalari_app/features/user/model/user_model.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../courses/models/subscription_course_model.dart';

class MyCourseProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  List<CourseModel> myCourses = [];
  bool addingCourseLoading = false;

  bool isFirebaseDataLoding = false;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;
  bool courseLoading = false;
  bool circularProgressLOading = true;
  bool isSearching = false;

//ADD NEW COURSE
  Future<bool> addCourse({
    required CourseModel course,
    required String registerNumber,
    required BuildContext context,
    required UserModel  user,
  }) async {
    bool result = false;
    addingCourseLoading = true;
    notifyListeners();

    try {
      final newSubScripton = SubscriptionCourseModel(
        mycourse: course,
        userId: FirebaseAuth.instance.currentUser?.uid,
        createdAt: Timestamp.now(),
        registerNumber: registerNumber,
      );
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid) //TODO: remove this
          .update({
        'mySubscription': FieldValue.arrayUnion([newSubScripton.toMap()])
      }).then((value) {
        //ADD NEW ASSESSMENT
        Provider.of<AssessmentProvider>(context, listen: false)
            .addNewAssessment(AssessmentModel(
          assessmentDteails: CourseAssessmentModel(
            totalMarks: course.assessemntDatails?.totalMarks,
            questionsCount: course.assessemntDatails?.questionsCount,
            duration: course.assessemntDatails?.duration,
          ),
          attemptsQuestion: [],
          courseId: course.id,
          courseLessons: course.lessons,
          createdAt: Timestamp.now(),
          userId: FirebaseAuth.instance.currentUser?.uid,
          courseName: course.title,
        totalQuestions: course.assessemntDatails?.questionsCount,
        userName: user.name,
        registerNumber: registerNumber,
        
      

        ));
      });

      myCourses.insert(0, course);

      notifyListeners();
      CustomToast.successToast(message: "Course added successfully");
      result = true;
    } catch (e) {
      log("ERROR$e");
      CustomToast.errorToast(message: "Something went wrong");
      result = false;
    }
    addingCourseLoading = false;
    notifyListeners();

    return result;
  }

  //GET MY COURSES

  Future<void> fetchAllMyCourses() async {
    log("FETCHING MY COURSES");
    isFirebaseDataLoding = true;
    notifyListeners();
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userDoc = await firestore.collection('users').doc(user?.uid).get();

      if (userDoc.data()?['mySubscription'] == null) {
        isFirebaseDataLoding = false;
        notifyListeners();
        return;
      }
      final mySubScription = userDoc.data()?['mySubscription'] as List<dynamic>;

      final mysubData = mySubScription
          .map<SubscriptionCourseModel>(
              (e) => SubscriptionCourseModel.fromMap(e))
          .toList();

      myCourses = [];

      for (var i = 0; i < mysubData.length; i++) {
        final element = mysubData[i];

        final myCoursesDocs = await firestore
            .collection('courses')
            .orderBy('createdAt', descending: true)
            .where('id', isEqualTo: element.mycourse?.id)
            .get();

        log("MY COURSES : ${myCoursesDocs.docs.length}");

        myCourses.add(CourseModel.fromMap(myCoursesDocs.docs.first.data()));
        isFirebaseDataLoding = false;

        notifyListeners();
      }
      log("MY COURSES : ${myCourses.length}");
    } catch (err) {
      log("ERROR IN fetch All Courses :$err");
    }

    notifyListeners();
  }

  List<LessonModel>? getRelatedLessons(
      LessonModel currentLesson, List<LessonModel> allLessons, int index) {
    List<LessonModel>? relatedLessons = [];

    return relatedLessons;
  }

  void clearData() {
    lastdoc = null;
    myCourses = [];
    isFirebaseDataLoding = false;
    courseLoading = false;
    circularProgressLOading = true;

    notifyListeners();
  }
}
