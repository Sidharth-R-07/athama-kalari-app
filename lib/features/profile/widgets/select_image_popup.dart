import 'dart:io';
import 'dart:developer';
import 'package:athma_kalari_app/features/user/provider/user_provider.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../general/services/upload_firestore_image_services.dart';

class ImageSelectionPopup extends StatefulWidget {
  @override
  _ImageSelectionPopupState createState() => _ImageSelectionPopupState();
}

class _ImageSelectionPopupState extends State<ImageSelectionPopup> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading:
                const Icon(IconlyLight.camera, color: AppColors.primaryColor),
            title: const Text(
              'Take a photo',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              userProvider.updateUserImageUrl(ImageSource.camera).whenComplete(
                  () => CustomToast.successToast(
                      message: "Image Updated Successfully"));
              Navigator.of(context).pop();
            },
          ),
          const Divider(
            color: AppColors.primaryColorLight,
            height: .5,
            thickness: .1,
          ),
          ListTile(
            leading:
                const Icon(IconlyLight.upload, color: AppColors.primaryColor),
            title: const Text(
              'Choose from gallery',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              userProvider.updateUserImageUrl(ImageSource.gallery).whenComplete(
                  () => CustomToast.successToast(
                      message: "Image Updated Successfully"));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
