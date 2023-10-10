import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../general/assets/app_icons.dart';
import '../../../general/services/custom_cached_network_image.dart';
import '../../../general/services/get_youtube_id_by_link.dart';
import '../../../general/utils/app_colors.dart';
import '../../courses/models/course_model.dart';
import '../screens/my_courses_lessons_screen.dart';

class MyCourseFrame extends StatelessWidget {
  const MyCourseFrame({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
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
                      'https://img.youtube.com/vi/${getYoutubeIdByLink(course.videoLink!)}/0.jpg',
                  height: 150,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Image.asset(
                  AppIcons.unLockIcon,
                  height: 28,
                  width: 28,
                ),
              )
            ],
          ),
          Expanded(
            child: Text(
              course.title!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            text: "${course.lessons!.length}",
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
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                      child: MyCoursesLessonScreen(course: course),
                      type: PageTransitionType.rightToLeftWithFade));
                },
                color: AppColors.primaryColor,
                minWidth: 110,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Learn Now",
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
