import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';

Future<void> removeFireStoreImgage({required List imageUrlList}) async {
  if (imageUrlList.isEmpty) {
    return;
  }
  try {
    List<Future<void>> functionList = [];
    for (var url in imageUrlList) {
      functionList.add(
        FirebaseStorage.instance.refFromURL(url).delete(),
      );
    }
    await Future.wait(functionList);
  } on Exception catch (e) {
    log(e.toString());
  }
}
