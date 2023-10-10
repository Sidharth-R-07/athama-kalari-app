import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/banner_model.dart';

class BannerProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  List<BannerModel> bannerList = [];

  bool isLoading = false;
  //FETCH BANNERS
  Future<void> fetchAllBanner() async {
    bannerList.clear();
    isLoading = true;
    notifyListeners();

    try {
      final refreshedClass = await firestore
          .collection('banners')
          .orderBy("createdAt", descending: true)
          .get();

      final data = refreshedClass.docs;

      for (var element in data) {
        final banner = BannerModel.fromMap(element.data());

        bannerList.add(banner);
        notifyListeners();
      }

      notifyListeners();

      log("FETCH ALL BANNER SUCCESSFULLY");
    } catch (err) {
      print("ERROR IN fetch BANNER :$err");
    }
    isLoading = false;
    notifyListeners();
  }
}
