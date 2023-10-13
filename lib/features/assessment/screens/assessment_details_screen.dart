import 'dart:developer';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:athma_kalari_app/features/assessment/provider/assessment_provider.dart';

import 'package:athma_kalari_app/features/home/widgets/introduction_video_container.dart';
import 'package:athma_kalari_app/general/assets/app_lotties.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'assessment_countdown_screen.dart';

class AssessmentDetailsScreen extends StatefulWidget {
  final AssessmentModel? assessment;
  const AssessmentDetailsScreen({super.key, this.assessment});

  @override
  State<AssessmentDetailsScreen> createState() =>
      _AssessmentDetailsScreenState();
}

class _AssessmentDetailsScreenState extends State<AssessmentDetailsScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final assessmentListner = Provider.of<AssessmentProvider>(context);
    final topicList =
        widget.assessment?.courseLessons?.map((e) => e.title).toList();
    final assessmentProvider =
        Provider.of<AssessmentProvider>(context, listen: false);

    final topicsString = topicList?.join(", ");
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: const Text(
          "Assessment",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: IntroductionVideoContainer(
                    videoUrl: assessmentListner.getIntroduction!.videoUrl!),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.bgWhite,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.assessment?.courseName}",
                    style: const TextStyle(
                        fontSize: 17,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text("Topics",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("$topicsString",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textColor.withOpacity(.7),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Terms",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 32 * 5,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: assessmentListner
                          .getIntroduction!.termsAndConditions!.length,
                      itemBuilder: (context, index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${assessmentListner.getIntroduction?.termsAndConditions?[index]}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          const SliverToBoxAdapter(
            child: Text(
              "   Before You Start",
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: AppColors.bgWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Conditions",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 10,
                  ),
                  ReadMoreText(
                    "${assessmentListner.getIntroduction?.about}",
                    trimMode: TrimMode.Line,
                    trimLines: 8,
                    moreStyle: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                    lessStyle: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      "I have read and agree to the terms and conditions",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.grey.withOpacity(.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 55,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: AppColors.bgWhite,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwipeButton.expand(
              width: 320,
              height: 58,
              thumbPadding: const EdgeInsets.all(6),
              thumb: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Lottie.asset(
                  AppLotties.letsStartAssessment,
                  height: 28,
                  width: 28,
                ),
              ),
              activeThumbColor: AppColors.primaryColor,
              activeTrackColor: AppColors.bgWhite,
              onSwipe: () async {
                if (!isChecked) {
                  CustomToast.errorToast(
                      message: "Please agree to the terms and conditions");
                } else {
                  Navigator.of(context).push(PageTransition(
                      child: AssessmentCountdownScreen(
                        assessment: widget.assessment,
                      ),
                      type: PageTransitionType.rightToLeftWithFade));
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let's Start",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    IconlyLight.arrow_right_2,
                    color: AppColors.primaryColor,
                    size: 14,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
