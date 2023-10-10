import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../general/app_details/app_details.dart';
import '../../../general/utils/app_colors.dart';

class SupportDetailsScreen extends StatelessWidget {
  const SupportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgWhite,
          surfaceTintColor: AppColors.bgWhite,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          title: const Text(
            'Customer Support',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          InkWell(
            onTap: () async {
              try {
                await launch("tel:${AppDetails.phoneNumber}");
              } catch (e) {
                print(e);
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppIcons.call,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Call',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Divider(
            color: AppColors.grey,
            thickness: .2,
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () async {
              try {
                await launch("https://wa.me/${AppDetails.whatsappNumber}");
              } catch (e) {
                print(e);
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppIcons.whatsapp,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Whatsapp',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Divider(
            color: AppColors.grey,
            thickness: .2,
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () async {
              try {
                await launch("mailto:${AppDetails.email}");
              } catch (e) {
                print(e);
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppIcons.email,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'E-mail',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
        ]));
  }
}
