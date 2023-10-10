import 'package:flutter/material.dart';

import '../assets/app_images.dart';
import '../utils/app_colors.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  const NoDataWidget({super.key, this.message = "No Data Found!"});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: ImageIcon(
              AssetImage(
                AppImages.athmaIcon,
              ),
              size: 90,
              color: AppColors.primaryColorLight,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "No Data Found!",
            style: TextStyle(
              color: AppColors.primaryColorLight,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
