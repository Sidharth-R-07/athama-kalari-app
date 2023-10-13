import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  List<CategoryModel> categoryList = [];
  CategoryModel? selectedCategory;
  bool isSearching = false;

  bool isLoading = false;

  Future<void> fetchAllCategory() async {
    log("fetchAllCategory() Called");
    categoryList = [];
    isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot<Map<String, dynamic>> refreshedClass = await firestore
          .collection('category')
          .orderBy("createdAt", descending: true)
          .get();

      final data = refreshedClass.docs;

      for (var element in data) {
        final event = CategoryModel.fromMap(element.data());

        categoryList.add(event);
        notifyListeners();
      }
      isLoading = false;

      notifyListeners();

      log("FETCH ALL CATEGORY SUCCESSFULLY");
    } catch (err) {
      print("ERROR IN fetch CATEGORY :$err");
    }
  }

  Future<void> searchCategory(String searchValue) async {
    isLoading = true;
    notifyListeners();

    try {
      final _categoryList = await firestore
          .collection('category')
          .where("keywords", arrayContains: searchValue.toLowerCase())
          .limit(6)
          .get();

      categoryList = _categoryList.docs
          .map(
            (e) => CategoryModel.fromMap(e.data()),
          )
          .toList();

      log("SEARCH Category LIST : $categoryList");

      notifyListeners();

      isSearching = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      print("ERRROR IN SEARCH EVENT " + e.toString());
    } catch (e) {
      print("ERRROR IN SEARCH EVENT " + e.toString());
    }
    isLoading = false;

    notifyListeners();
  }

  void clearData() {
    clearData();
    categoryList.clear();

    notifyListeners();
  }
}
