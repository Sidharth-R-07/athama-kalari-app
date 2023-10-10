import 'dart:developer';

import 'package:athma_kalari_app/features/user/model/user_model.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? userData;
  User? currentUser = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool addLoading = false;

  //UPDATE CURRENT USER STATUS

  Future<void> updateAuthcurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  //STORE USER DETAILS

  Future<bool> storeUserData(UserModel user) async {
    bool isStored = false;
    addLoading = true;
    notifyListeners();
    try {
      final ref = firestore.collection('users');

      await ref.doc(FirebaseAuth.instance.currentUser?.uid).set(user.toMap());
      await updateRegisterNumber();
      log('User Added Successfully');
      isStored = true;
    } catch (err) {
      isStored = false;
      CustomToast.errorToast(message: 'Something went wrong');
      log(err.toString());
    }
    addLoading = false;
    notifyListeners();
    return isStored;
  }

  //GET USER DETAILS
  Future<void> fetchUserDetails() async {
    try {
      final querysnap = await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      final data = querysnap.data();

      userData = UserModel.fromMap(data as Map<String, dynamic>);

      notifyListeners();

      log('User Data Fetched Successfully');
    } catch (e) {
      CustomToast.errorToast(message: 'Something went wrong');
      log(e.toString());
    }
  }

  //GET REGISTER NUMBER
  Future<int?> getRegisterNumber(BuildContext context) async {
    int? registerNumber;
    isLoading = true;
    notifyListeners();
    try {
      final query = await firestore.collection('general').doc('general').get();
      final data = query.data() as Map<String, dynamic>;
      registerNumber = data['currentRegisterNumber'] as int;
      log(registerNumber.toString());
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomToast.errorToast(message: 'Something went wrong');
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();

    return registerNumber;
  }

  //UPDATE REGISTER NUMBER
  Future<bool> updateRegisterNumber() async {
    log('update register number');
    bool isUpdated = false;
    try {
      final ref = firestore.collection('general').doc('general');
      await ref.update({'currentRegisterNumber': FieldValue.increment(1)});
      isUpdated = true;
    } catch (e) {
      CustomToast.errorToast(message: 'Something went wrong');
      log(e.toString());
    }
    return isUpdated;
  }

  //CLEAR DATA
  void clearData() {
    userData = null;
    currentUser = null;
    notifyListeners();
  }
}
