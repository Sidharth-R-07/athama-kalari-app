import 'dart:io';
import 'dart:developer';

import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class PdfServices {
  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = url.substring(url.lastIndexOf("/") + 1);
    log("FILE NAME : $filename");

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<void> downloadPDF(String url) async {
    log("URL : $url");
    try {
      final permissionStatus = await Permission.storage.request();

      if (permissionStatus == PermissionStatus.granted) {
        // The permission was granted.
        log("PERMISSION GRANTED");
      } else if (permissionStatus == PermissionStatus.denied) {
        log("PERMISSION DENIED");
        // The permission was denied.
      } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
        log("PERMISSION PERMANENTLY DENIED");
        // The permission was permanently denied.
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();

        final filePath = '${directory.path}/downloaded.pdf';
        final file = await File(filePath).writeAsBytes(response.bodyBytes);
        // Now, you have the PDF file saved locally at 'filePath'.
        print('PDF downloaded to: $filePath');
        CustomToast.successToast(message: 'PDF downloaded to: $filePath');
        log('PDF downloaded to: $filePath');
      } else {
        print('Failed to download PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }
}
