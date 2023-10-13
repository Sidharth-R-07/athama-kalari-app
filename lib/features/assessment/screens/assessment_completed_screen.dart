import 'package:athma_kalari_app/features/home/widgets/bottom_bar.dart';
import 'package:athma_kalari_app/general/assets/app_lotties.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class AssessmentCompletedScreen extends StatelessWidget {
  const AssessmentCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.bgGrey,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AppLotties.assessmentCompleted,
                height: 100,
                width: 100,
                repeat: false,
              ),
              const SizedBox(height: 20),
              const Text(
                "Successfully Completed",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Your Answer Sheet Under Review.Check Later After Some Time Or Contact Customer Care.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w300,
                    height: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 120,
          width: double.infinity,
          color: AppColors.bgGrey,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                          child: BottomBar(currentIndex: 2),
                          type: PageTransitionType.leftToRightWithFade),
                      (route) => false);
                },
                child: const Text(
                  "Go to My Courses",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColorLight,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  //NAVIGATE TO HOME

                  Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                          child: BottomBar(currentIndex: 0),
                          type: PageTransitionType.leftToRightWithFade),
                      (route) => false);
                },
                height: 45,
                minWidth: double.infinity,
                color: AppColors.primaryColor,
                textColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Back to Home",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
