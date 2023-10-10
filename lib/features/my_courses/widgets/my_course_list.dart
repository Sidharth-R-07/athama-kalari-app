// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:athma_kalari_app/features/my_courses/screens/my_courses_lessons_screen.dart';
import 'package:athma_kalari_app/general/services/custom_image_shimmer.dart';
import 'package:athma_kalari_app/general/services/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:athma_kalari_app/features/courses/screens/course_details_screen.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../general/assets/app_icons.dart';
import '../../../general/services/custom_cached_network_image.dart';
import '../../../general/services/get_youtube_id_by_link.dart';
import '../../courses/models/course_model.dart';
import '../providers/my_courses_provider.dart';
import 'my_course_frame.dart';

class MyCourseList extends StatelessWidget {
  final List<CourseModel>? courseList;
  const MyCourseList({Key? key, this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myCourseListner = Provider.of<MyCourseProvider>(context);

    return myCourseListner.isFirebaseDataLoding
        ? const Center(
            child: CustomImageShimmer(
              height: 70,
              width: 70,
            ),
          )
        : courseList!.isEmpty
            ? const Center(
                child: NoDataWidget(message: "No Courses Found"),
              )
            : ListView.separated(
                itemCount: courseList!.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    MyCourseFrame(course: courseList![index]),
              );
  }
}
