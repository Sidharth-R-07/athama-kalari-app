import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../models/course_model.dart';

class LessonFrame extends StatelessWidget {
  final LessonModel? lesson;
  final int? index;
  const LessonFrame({super.key, this.lesson, this.index});

  @override
  Widget build(BuildContext context) {
    String formattedNumber = (index! + 1).toString().padLeft(2, '0');
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppColors.primaryColorLight.withOpacity(.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.bgWhite,
            child: Text(
              formattedNumber,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              lesson!.title!,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(
            AppIcons.lockIcon,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
