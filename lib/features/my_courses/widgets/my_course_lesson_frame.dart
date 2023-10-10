import 'dart:developer';

import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:athma_kalari_app/features/my_courses/screens/my_course_lesson_details_screen.dart';
import 'package:athma_kalari_app/general/services/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../general/assets/app_icons.dart';
import '../../../general/services/get_youtube_id_by_link.dart';

class MyCourseLessonFrame extends StatefulWidget {
  final int index;
  final LessonModel lesson;
  final List<LessonModel> allLessons;
  const MyCourseLessonFrame(
      {super.key,
      required this.lesson,
      required this.index,
      required this.allLessons});

  @override
  State<MyCourseLessonFrame> createState() => _MyCourseLessonFrameState();
}

class _MyCourseLessonFrameState extends State<MyCourseLessonFrame> {
  @override
  Widget build(BuildContext context) {
    String formattedNumber = (widget.lesson.index).toString().padLeft(2, '0');
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: MyLessonDetailsScreen(
              lesson: widget.lesson,
              index: widget.index,
              allLessons: widget.allLessons,
            ),
            type: PageTransitionType.rightToLeftWithFade));
      },
      child: Container(
        height: 216,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomCachedNetworkImage(
                    height: 150,
                    width: double.infinity,
                    imageUrl:
                        'https://img.youtube.com/vi/${getYoutubeIdByLink(widget.lesson.videoLink!)}/0.jpg'),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppIcons.videoPlayButton,
                    width: 30,
                    height: 30,
                  ))
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                formattedNumber,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.lesson.title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
        ]),
      ),
    );
  }
}
