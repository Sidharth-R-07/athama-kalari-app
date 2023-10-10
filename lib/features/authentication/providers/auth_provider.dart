import 'dart:developer';

import 'package:athma_kalari_app/features/authentication/screens/add_user_details_screen.dart';
import 'package:athma_kalari_app/features/authentication/screens/otp_verification_screen.dart';
import 'package:athma_kalari_app/features/user/provider/user_provider.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  String _verificationId = "";
  int? _resendToken;
  bool veryfyPhoneLoading = false;
  bool veryfyOtpLoading = false;
  bool showResendOtp = false;

  bool logoutLoading = false;

  //VERY PHONE NUMBER
  Future<void> veryPhoneNumber({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    log('very phone number called');
    veryfyPhoneLoading = true;
    notifyListeners();
    log('loading : $veryfyPhoneLoading');

    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        veryfyPhoneLoading = false;
        notifyListeners();
        CustomToast.errorToast(message: e.message.toString());
        log(e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;

        _resendToken = resendToken;
        veryfyPhoneLoading = false;

        log('verification id : $_verificationId');
        notifyListeners();
        CustomToast.successToast(message: 'Code Sent Successfully');
        Navigator.of(context).push(PageTransition(
            child: OtpVerificationSccreen(
              phone: phoneNumber,
            ),
            type: PageTransitionType.rightToLeftWithFade));

        log('code sent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        veryfyPhoneLoading = false;
        notifyListeners();

        log('code timeout');
      },
    );
  }

  //void showResend token is true
  void showResendToken() {
    showResendOtp = true;
    notifyListeners();
  }

  //RESEND CODE
  Future<void> resendCode(String phoneNumber) async {
    log('resend code called');

    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
        notifyListeners();

        print('code sent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        notifyListeners();
        print('code timeout');
      },
      forceResendingToken: _resendToken,
    );
  }

  //VERIFY OTP
  verifyOtp({
    required String otp,
    required BuildContext context,
    required String phoneNumber,
  }) async {
    log('verify otp called');

    log("OTPP:$otp");
    log("VERIFICATION ID:$_verificationId");
    veryfyOtpLoading = true;
    notifyListeners();
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      final result =
          await auth.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          await FirebaseMessaging.instance.subscribeToTopic('allUsers');
          final fcmToken = await FirebaseMessaging.instance.getToken();

          final docRef = FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid);

          docRef.get().then((DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {
              log('Document exists');

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .update({
                'fcmToken': fcmToken,
              }).whenComplete(() async {
                await Provider.of<UserProvider>(context, listen: false)
                    .fetchUserDetails()
                    .whenComplete(() {
                  Provider.of<UserProvider>(context, listen: false)
                      .updateAuthcurrentUser();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              });
            } else {
              log('Document does not exist');

              Navigator.of(context).push(PageTransition(
                  child: AddUserDetailsScreen(
                    phoneNumber: phoneNumber,
                  ),
                  type: PageTransitionType.rightToLeftWithFade));
            }
          });
        }
      });
    } on FirebaseAuthException catch (err) {
      log("FIREBASE AUTH EXCEPTION :${err.message.toString()}");
      CustomToast.errorToast(message: err.message.toString());
    } catch (e) {
      log(e.toString());
      CustomToast.errorToast(message: e.toString());
    }
    veryfyOtpLoading = false;
    notifyListeners();
  }

  //LOGOUT USER
  Future<bool> logoutUser(BuildContext context) async {
    bool isLoggedOut = false;
    logoutLoading = true;
    notifyListeners();
    try {
      await auth.signOut().whenComplete(() {
        Provider.of<UserProvider>(context, listen: false).clearData();
      });

      isLoggedOut = true;
    } catch (e) {
      log(e.toString());
      CustomToast.errorToast(message: e.toString());
    }
    logoutLoading = false;
    notifyListeners();
    return isLoggedOut;
  }

  clearData() {
    _resendToken = null;

    veryfyPhoneLoading = false;
    veryfyOtpLoading = false;
    showResendOtp = false;
    notifyListeners();
  }
}
