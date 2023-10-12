import 'dart:developer';

import 'package:athma_kalari_app/features/courses/screens/course_screen.dart';
import 'package:athma_kalari_app/features/sub_category/models/sub_category_model.dart';
import 'package:athma_kalari_app/general/services/custom_cached_network_image.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SubCategoryFrame extends StatelessWidget {
  final String? categoryId;
  final SubCategoryModel? subCategory;
  const SubCategoryFrame({super.key, this.subCategory, this.categoryId});

  @override
  Widget build(BuildContext context) {
    log("SubCategoryFrame: ${subCategory?.courses?.length}");
    return Container(
      width: 329,
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CustomCachedNetworkImage(
              imageUrl: subCategory!.image!,
              width: 125,
              height: 114,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${subCategory?.title}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black),
              ),
              const SizedBox(height: 4),
              Text(
                "Courses : ${subCategory?.courses?.length ?? 0}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 12),
              MaterialButton(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minWidth: 180,
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(
                        child: CourseScreen(
                          subCategory: subCategory,
                          categoryId: categoryId,
                        ),
                        type: PageTransitionType.rightToLeftWithFade));
                  },
                  child: const Text(
                    "View Courses",
                    style: TextStyle(
                      color: AppColors.bgWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
