import 'dart:developer';

import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:athma_kalari_app/features/home/models/search_model.dart';
import 'package:athma_kalari_app/features/sub_category/models/sub_category_model.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../general/enums/search_type_enum.dart';

class SearchProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<SearchCombineModel> searchResults = [];
  bool searchLoading = false;
  //GET SEARCH RESULT
  Future<void> getSearchResult(String value) async {
    log("SEARCH VALUE: $value");
    final searchText = value.replaceAll(" ", '');
    searchLoading = true;
    notifyListeners();

    try {
      //FETCHING SUBCATEGORY
      final subquery = await _firestore
          .collection('sub-category')
          .where('keywords', arrayContains: searchText)
          .limit(6)
          .orderBy('createdAt', descending: true)
          .get();
      final _subData = subquery.docs
          .map<SubCategoryModel>((e) => SubCategoryModel.fromMap(e.data()))
          .toList();
      for (var element in _subData) {
        searchResults.insert(
            0,
            SearchCombineModel(
              model: element,
              type: SearchTypeEnum.subcategory,
            ));
        notifyListeners();
      }

      //FETCHING COURSE
      final courseQuery = await _firestore
          .collection('courses')
          .where('keywords', arrayContains: searchText)
          .limit(8)
          .orderBy('createdAt', descending: true)
          .get();
      final _courseData = courseQuery.docs
          .map<CourseModel>((e) => CourseModel.fromMap(e.data()))
          .toList();

      log("COURSE DATA: $_courseData");
      for (var element in _courseData) {
        searchResults.add(SearchCombineModel(
          model: element,
          type: SearchTypeEnum.course,
        ));
        notifyListeners();
      }

      log("SEARCH RESULT: ${searchResults.length}");
    } catch (e) {
      log("ERROR IN SEARCH RESULT: $e");
    }
    searchLoading = false;
    notifyListeners();
  }
}
