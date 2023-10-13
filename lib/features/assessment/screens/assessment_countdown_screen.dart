import 'dart:developer';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:athma_kalari_app/features/assessment/screens/questions_screen.dart';
import 'package:athma_kalari_app/general/assets/app_lotties.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../provider/assessment_provider.dart';

class AssessmentCountdownScreen extends StatefulWidget {
  final AssessmentModel? assessment;
  const AssessmentCountdownScreen({super.key, this.assessment});

  @override
  State<AssessmentCountdownScreen> createState() =>
      _AssessmentCountdownScreenState();
}

class _AssessmentCountdownScreenState extends State<AssessmentCountdownScreen> {
  bool showIndicator = false;

  @override
  void initState() {
    //FETHCING QUESTIONS
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final assessmentProvider =
          Provider.of<AssessmentProvider>(context, listen: false);
      assessmentProvider.cleardata();

      if (widget.assessment?.courseId != null &&
          widget.assessment?.assessmentDteails?.questionsCount != null) {
        assessmentProvider.fetchQuestion(widget.assessment!.courseId!,
            widget.assessment!.assessmentDteails!.questionsCount!);
      } else {
        CustomToast.errorToast(message: "NO QUESTIONS FOUND");
      }
    });
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showIndicator = true;
      });
      Navigator.of(context).pushReplacement(PageTransition(
          child: QuestionsScreen(
            assessment: widget.assessment,
          ),
          type: PageTransitionType.fade));
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      setState(() {
        showIndicator = false;
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Center(
        child: showIndicator
            ? const CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeAlign: 6,
                strokeWidth: 2,
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "START IN",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Lottie.asset(
                    AppLotties.assessmentCountdown,
                    height: 200,
                    width: 200,
                  )
                ],
              ),
      ),
    );
  }
}
