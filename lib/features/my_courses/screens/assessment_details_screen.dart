import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:athma_kalari_app/features/courses/screens/course_details_screen.dart';
import 'package:athma_kalari_app/features/home/widgets/introduction_video_container.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
                child: const IntroductionVideoContainer(
                    videoUrl:
                        "https://youtu.be/2lZ4ZbNGVUU?si=si1xRIZnZljA1VJA"),
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
                  const Text(
                    "Mei Payattu",
                    style: TextStyle(
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
                  Text(
                      "introduction to kalari  payattu, attack, deffence, poozhikadakam, olinj maattam",
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
                        itemCount: 5,
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
                                  "Terms and condition $index",
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
                            )),
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Conditions",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    loremIpus,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
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
      bottomSheet: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            color: AppColors.primaryColor,
            minWidth: size.width * 0.9,
            height: 42,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              if (!isChecked) {
                CustomToast.errorToast(
                    message: "Please agree to the terms and conditions");
              }
            },
            child: const Text(
              'Lets Start',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
