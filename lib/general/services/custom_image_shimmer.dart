import 'package:athma_kalari_app/general/assets/app_images.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  const CustomImageShimmer({super.key, this.height = 10, this.width = 10});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.bgGrey,
      highlightColor: AppColors.primaryColorLight,
      child: Image.asset(
        AppImages.athmaIcon,
        height: height,
        width: width,
      ),
    );
  }
}
