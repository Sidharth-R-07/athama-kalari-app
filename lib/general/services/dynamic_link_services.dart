import 'dart:developer';

import 'package:athma_kalari_app/general/app_details/app_details.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';

class DynamicLinkServices {
  static Future<String> createDynamicLink(String prodId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: AppDetails.urlPrfix,
        link: Uri.parse('${AppDetails.appUrl}?prodId=$prodId'),
        androidParameters: const AndroidParameters(
          packageName: AppDetails.appName,
          minimumVersion: 0,
        ),
        iosParameters: const IOSParameters(
          bundleId: AppDetails.bundleID,
          minimumVersion: '0',
        ));
    // final Uri dynamicUrl = await parameters.buildUrl();
    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  //initializing dynamic link
  static Future handleDynamicLinks() async {
    log("DYNAMIC LINK INIT");
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      final Uri deepLink = data.link;
      log("DEEP LINK PATH : ${deepLink.queryParameters['prodId']}");
      final prodId = deepLink.queryParameters['prodId'];
      log("DEEP LINK PATH : $prodId");
    } else {
      log("NO DEEP LINK");
    }

    log("${FirebaseDynamicLinks.instance.onLink}");
  }
}
