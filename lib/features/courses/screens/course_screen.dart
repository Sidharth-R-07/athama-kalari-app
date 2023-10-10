import 'dart:developer';

import 'package:athma_kalari_app/features/courses/provider/course_provider.dart';
import 'package:athma_kalari_app/features/courses/widgets/course_frame.dart';
import 'package:athma_kalari_app/features/my_courses/widgets/my_course_frame.dart';
import 'package:athma_kalari_app/features/sub_category/models/sub_category_model.dart';
import 'package:athma_kalari_app/features/user/provider/user_provider.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../general/services/custom_image_shimmer.dart';
import '../../../general/services/custom_lazy_loading.dart';
import '../../../general/services/no_data_widget.dart';

class CourseScreen extends StatefulWidget {
  final SubCategoryModel? subCategory;
  final String? categoryId;
  const CourseScreen({
    super.key,
    this.subCategory,
    this.categoryId,
  });

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final scrollController = ScrollController();
  _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CourseProvider>(context, listen: false).clearData();
      await Provider.of<CourseProvider>(context, listen: false)
          .fetchSubCategoryCourse(widget.subCategory!);
    });
  }

  @override
  void initState() {
    _getData();

    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0 &&
          Provider.of<CourseProvider>(context, listen: false).courseLoading ==
              false &&
          Provider.of<CourseProvider>(context, listen: false)
                  .circularProgressLOading ==
              true) {
        Provider.of<CourseProvider>(context, listen: false)
            .fetchSubCategoryCourse(widget.subCategory!);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseListner = Provider.of<CourseProvider>(context);

    final userCourses =
        Provider.of<UserProvider>(context).userData?.subSCriptionCourses;

    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: Text(
          "${widget.subCategory?.title}",
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: courseListner.isFirebaseDataLoding
          ? const Center(
              child: SizedBox(
                height: 90,
                width: 90,
                child: CustomImageShimmer(),
              ),
            )
          : courseListner.courseList.isEmpty
              ? const NoDataWidget(
                  message: "No Course Found !",
                )
              : Container(
                  margin: const EdgeInsets.all(8.0),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverList.separated(
                        itemCount: courseListner.courseList.length,
                        itemBuilder: (context, index) {
                          if (userCourses != null) {
                            for (var element in userCourses) {
                              log(element.mycourse!.id!);
                              if (element.mycourse!.id ==
                                  courseListner.courseList[index].id) {
                                return MyCourseFrame(
                                    course: courseListner.courseList[index]);
                              }
                            }
                          }
                          return CourseFrame(
                              course: courseListner.courseList[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: (courseListner.circularProgressLOading &&
                                courseListner.isFirebaseDataLoding == false)
                            ? const CustomLazyLoading()
                            : Container(),
                      )
                    ],
                  ),
                ),
    );
  }
}
