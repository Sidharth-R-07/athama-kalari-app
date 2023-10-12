import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sub_category_model.dart';

class SubCategoryProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  List<SubCategoryModel> subCategoryList = [];
  SubCategoryModel? selectedSubCategory;
  bool addSubCategoryLoading = false;
  bool deleteSubCategoryLoading = false;

  bool isFirebaseDataLoding = false;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;
  bool subCategoryLoading = false;
  bool circularProgressLOading = true;
  bool isSearching = false;

  Future<void> fetchAllSubCategory(String categoryId) async {
    if (subCategoryList.isEmpty) {
      isFirebaseDataLoding = true;
    }
    subCategoryLoading = true;
    notifyListeners();
    log("fetchAllSubCategory() Called");

    try {
      QuerySnapshot<Map<String, dynamic>> refreshedClass = (lastdoc == null)
          ? await firestore
              .collection('sub-category')
              .where("categoryModel.id", isEqualTo: categoryId)
              .orderBy("createdAt", descending: true)
              .limit(6)
              .get()
          : await firestore
              .collection('sub-category')
              .where("categoryModel.id", isEqualTo: categoryId)
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
        log("FETCH ALL SUB_CATEGORY : ${element.data()}");
        final subCat = SubCategoryModel.fromMap(element.data());

        subCategoryList.add(subCat);
        notifyListeners();
      }

      subCategoryLoading = false;

      notifyListeners();

      log("FETCH ALL SUB_CATEGORY SUCCESSFULLY");
    } catch (err) {
      print("ERROR IN fetch SUB_CATEGORY :$err");
    }
  }

  Future<void> searchSubCategory(String searchValue, String categoryId) async {
    isFirebaseDataLoding = true;
    notifyListeners();

    try {
      final _categoryList = await firestore
          .collection('sub-category')
          .where("categoryModel.id", isEqualTo: categoryId)
          .where("keywords", arrayContains: searchValue.toLowerCase())
          .orderBy("createdAt", descending: true)
          .limit(6)
          .get();

      subCategoryList = _categoryList.docs
          .map(
            (e) => SubCategoryModel.fromMap(e.data()),
          )
          .toList();

      log("SEARCH Category LIST : $subCategoryList");

      notifyListeners();

      isSearching = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      print("ERRROR IN SEARCH EVENT " + e.toString());
    } catch (e) {
      print("ERRROR IN SEARCH EVENT " + e.toString());
    }
    isFirebaseDataLoding = false;
    notifyListeners();
  }

  void clearData() {
    selectedSubCategory = null;
    lastdoc = null;
    subCategoryList = [];
    isFirebaseDataLoding = false;
    subCategoryLoading = false;
    circularProgressLOading = true;

    notifyListeners();
  }
}
