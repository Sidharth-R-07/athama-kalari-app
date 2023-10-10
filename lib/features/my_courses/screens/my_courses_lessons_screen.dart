import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:athma_kalari_app/features/my_courses/widgets/my_course_lesson_frame.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyCoursesLessonScreen extends StatelessWidget {
  final CourseModel? course;
  const MyCoursesLessonScreen({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWhite,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: Text(
          course!.title!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: course!.lessons!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 6),
        itemBuilder: (context, index) => MyCourseLessonFrame(
          allLessons: course!.lessons!,
          index: index,
          lesson: course!.lessons![index],
        ),
      ),
    );
  }
}
