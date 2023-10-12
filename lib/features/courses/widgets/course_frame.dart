import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:athma_kalari_app/features/courses/screens/course_details_screen.dart';
import 'package:athma_kalari_app/general/services/custom_cached_network_image.dart';
import 'package:athma_kalari_app/general/services/get_youtube_id_by_link.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../general/assets/app_icons.dart';
import '../../../general/utils/app_colors.dart';

class CourseFrame extends StatelessWidget {
  final CourseModel? course;
  const CourseFrame({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bgWhite,
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomCachedNetworkImage(
                  imageUrl:
                      'https://img.youtube.com/vi/${getYoutubeIdByLink(course!.videoLink!)}/0.jpg',
                  height: 150,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Image.asset(
                  AppIcons.lockIcon,
                  height: 28,
                  width: 28,
                ),
              )
            ],
          ),
          Text(
            course!.title!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppIcons.playButtonSmall,
                          height: 12,
                          width: 12,
                        ),
                        const SizedBox(width: 6),
                        RichText(
                          text: TextSpan(
                            text: "Lessons : ",
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: "${course!.lessons!.length}",
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "₹ ${course?.courseFee}",
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                      child: CourseDetailsScreen(course: course!),
                      type: PageTransitionType.rightToLeftWithFade));
                },
                color: AppColors.primaryColor,
                minWidth: 110,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                    color: AppColors.bgWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
