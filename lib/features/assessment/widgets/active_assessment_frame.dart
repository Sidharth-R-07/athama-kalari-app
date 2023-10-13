import 'dart:developer';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:athma_kalari_app/features/assessment/screens/assessment_details_screen.dart';
import 'package:athma_kalari_app/general/assets/app_lotties.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../../general/assets/app_icons.dart';
import '../screens/assessment_completed_screen.dart';

class ActiveAssessmentFrame extends StatelessWidget {
  final AssessmentModel? assessment;
  const ActiveAssessmentFrame({super.key, this.assessment});

  @override
  Widget build(BuildContext context) {
    log("ASSESSMENT ID: ${assessment?.id}");
    return Container(
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 2,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${assessment?.courseName}",
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppIcons.assessmentTime,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 5),
              Text(
                "${assessment?.assessmentDteails?.duration} Minutes",
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppIcons.assessmentMark,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 5),
              Text(
                "${assessment?.assessmentDteails?.totalMarks} Marks",
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppIcons.assessmentQuestion,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 5),
              Text(
                "${assessment?.assessmentDteails?.questionsCount} Questions",
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              (assessment?.isSubmitted == true && assessment?.isPassed == null)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColorLight,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            AppLotties.assessmentReviewing,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Reviewing...",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            child:
                                AssessmentDetailsScreen(assessment: assessment),
                            type: PageTransitionType.rightToLeftWithFade));
                      },
                      color: AppColors.primaryColor,
                      textColor: AppColors.bgWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: const Text("Enroll"),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
