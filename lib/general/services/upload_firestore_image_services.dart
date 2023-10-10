import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'custom_toast.dart';

Future<String?> uploadFirestoreImageServices(Uint8List image) async {
  log("uploadFirestoreImageServices");
  try {
    var storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child('images')
        .child('${Timestamp.now().microsecondsSinceEpoch}.jpeg');
    final value = await ref.putData(
      image,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await value.ref.getDownloadURL();
  } catch (e) {
    log("Error Found:$e");
    CustomToast.errorToast(message: "Error Found:$e");
    return null;
  }
}
