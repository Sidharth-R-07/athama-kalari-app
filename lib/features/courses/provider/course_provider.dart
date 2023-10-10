import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../sub_category/models/sub_category_model.dart';
import '../models/course_model.dart';

class CourseProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  List<CourseModel> courseList = [];
  bool addCourseLoading = false;
  bool addQuestionLoading = false;
  CourseModel? selectedCourse;

  bool isFirebaseDataLoding = false;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;
  bool courseLoading = false;
  bool circularProgressLOading = true;
  bool isSearching = false;

  String? extractVideoId(String url) {
    final RegExp regExp = RegExp(r"youtu\.be/([a-zA-Z0-9_-]+)");
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    } else {
      return "Invalid URL";
    }
  }

  //get courses
  Future<void> fetchSubCategoryCourse(SubCategoryModel subCategory) async {
    if (courseList.isEmpty) {
      isFirebaseDataLoding = true;
    }
    courseLoading = true;
    log("fetchAllCourse() Called");

    try {
      QuerySnapshot<Map<String, dynamic>> refreshedClass = (lastdoc == null)
          ? await firestore
              .collection('courses')
              .where("subCategory.id", isEqualTo: subCategory.id)
              .where("subCategory.categoryModel.id",
                  isEqualTo: subCategory.categoryModel!.id)
              .orderBy("createdAt", descending: true)
              .limit(6)
              .get()
          : await firestore
              .collection('courses')
              .where("subCategory.id", isEqualTo: subCategory.id)
              .where("subCategory.categoryModel.id",
                  isEqualTo: subCategory.categoryModel!.id)
              .orderBy("createdAt", descending: true)
              .startAfterDocument(lastdoc!)
              .limit(4)
              .get(const GetOptions(source: Source.serverAndCache));

      isFirebaseDataLoding = false;
      if (refreshedClass.docs.length >= (lastdoc == null ? 6 : 4)) {
        lastdoc = refreshedClass.docs.last;
      } else {
        circularProgressLOading = false;

        notifyListeners();
      }
      final data = refreshedClass.docs;

      for (var element in data) {
        final course = CourseModel.fromMap(element.data());

        courseList.add(course);
        notifyListeners();
      }

      courseLoading = false;

      notifyListeners();

      log("FETCH ALL Course SUCCESSFULLY");
    } catch (err) {
      print("ERROR IN fetch All Courses :$err");
    }
  }

//SEARCH COURSE

  Future<void> searchCourse(
      String searchValue, SubCategoryModel subCategory) async {
    isFirebaseDataLoding = true;
    notifyListeners();

    try {
      final _categoryList = await firestore
          .collection('courses')
          .where("subCategory.id", isEqualTo: subCategory.id)
          .where("subCategory.categoryModel.id",
              isEqualTo: subCategory.categoryModel!.id)
          .orderBy("createdAt", descending: true)
          .where("keywords", arrayContains: searchValue.toLowerCase())
          .limit(6)
          .get();

      courseList = _categoryList.docs
          .map(
            (e) => CourseModel.fromMap(e.data()),
          )
          .toList();

      log("SEARCH Course LIST : $courseList");

      notifyListeners();

      isSearching = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      print("ERRROR IN SEARCH Course " + e.toString());
    } catch (e) {
      print("ERRROR IN SEARCH Course " + e.toString());
    }
    isFirebaseDataLoding = false;

    notifyListeners();
  }

//FETCH ALL COURSES

  //get courses
  Future<void> fetchAllCourses() async {
    if (courseList.isEmpty) {
      isFirebaseDataLoding = true;
    }
    courseLoading = true;
    log("fetchAllCourse() Called");

    try {
      QuerySnapshot<Map<String, dynamic>> refreshedClass = (lastdoc == null)
          ? await firestore
              .collection('courses')
              .orderBy("createdAt", descending: true)
              .limit(6)
              .get()
          : await firestore
              .collection('courses')
              .orderBy("createdAt", descending: true)
              .startAfterDocument(lastdoc!)
              .limit(4)
              .get(const GetOptions(source: Source.serverAndCache));

      isFirebaseDataLoding = false;
      if (refreshedClass.docs.length >= (lastdoc == null ? 6 : 4)) {
        lastdoc = refreshedClass.docs.last;
      } else {
        circularProgressLOading = false;

        notifyListeners();
      }
      final data = refreshedClass.docs;

      for (var element in data) {
        final course = CourseModel.fromMap(element.data());

        courseList.add(course);
        notifyListeners();
      }

      courseLoading = false;

      notifyListeners();

      log("FETCH ALL Course SUCCESSFULLY");
    } catch (err) {
      print("ERROR IN fetch All Courses :$err");
    }
  }

  //ALL COURSE SEARCH
  Future<void> searchAllCourse(String searchValue) async {
    isFirebaseDataLoding = true;
    notifyListeners();

    try {
      final _categoryList = await firestore
          .collection('courses')
          .orderBy("createdAt", descending: true)
          .where("keywords", arrayContains: searchValue.toLowerCase())
          .limit(6)
          .get();

      courseList = _categoryList.docs
          .map(
            (e) => CourseModel.fromMap(e.data()),
          )
          .toList();

      log("SEARCH Course LIST : $courseList");

      notifyListeners();

      isSearching = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      print("ERRROR IN SEARCH Course " + e.toString());
    } catch (e) {
      print("ERRROR IN SEARCH Course " + e.toString());
    }
    isFirebaseDataLoding = false;

    notifyListeners();
  }

  void clearData() {
    lastdoc = null;
    courseList = [];
    isFirebaseDataLoding = false;
    courseLoading = false;
    circularProgressLOading = true;

    notifyListeners();
  }
}
