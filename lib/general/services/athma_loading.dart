import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../assets/app_images.dart';

class AthmaLoading extends StatelessWidget {
  const AthmaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(alignment: Alignment.center, children: [
        Image.asset(
          AppImages.athmaLoading,
          height: 80,
          width: 80,
        ),
        // LoadingAnimationWidget.threeArchedCircle(
        //   color: const Color(0xff159c31),
        //   size: 80,

        // )
        const CircularProgressIndicator(
          strokeAlign: 8,
          strokeCap: StrokeCap.round,
          strokeWidth: 2,
          backgroundColor: AppColors.primaryColorLight,
          color: Color(0xff159c31),
        )
      ]),
    );
  }
}
