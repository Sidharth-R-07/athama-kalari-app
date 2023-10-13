import 'dart:developer';

import 'package:athma_kalari_app/features/assessment/provider/assessment_provider.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/my_courses_provider.dart';
import 'my_certificates_screen.dart';
import '../widgets/my_course_list.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final scrollcontroller = ScrollController();

  _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final myCourseProvider =
          Provider.of<MyCourseProvider>(context, listen: false);
      final myAssessmentProvider =
          Provider.of<AssessmentProvider>(context, listen: false);
      await myCourseProvider.fetchAllMyCourses();
      await myAssessmentProvider.getAssessmentIntroduction();
      await myAssessmentProvider.fetchMyAssessment();
    });
  }

  @override
  void initState() {
    _getData();
    _tabController = TabController(length: 2, vsync: this);

    scrollcontroller.addListener(() {
      log("SCROLLING");
      if (scrollcontroller.position.atEdge) {
        if (scrollcontroller.position.pixels == 0) {
          // The user is scrolling to the top of the list, so don't load more courses.
        } else {
          log("SCROLLING TO BOTTOM");
          // The user is scrolling to the bottom of the list, so load more courses.
          Provider.of<MyCourseProvider>(context, listen: false)
              .fetchAllMyCourses();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myCourseListner = Provider.of<MyCourseProvider>(context);
    final myAssessMentListner = Provider.of<AssessmentProvider>(context);

    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.bgWhite,
            surfaceTintColor: AppColors.bgWhite,
            floating: true,
            pinned: true,
            snap: true,
            title: TabBar(
              dividerColor: AppColors.bgWhite,
              controller: _tabController,
              labelStyle: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(
                  text: 'My Classes',
                ),
                Tab(
                  text: 'Certificates',
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 10,
          )),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                // MyCourseList(),

                MyCourseList(courseList: myCourseListner.myCourses),
                // Center(
                //   child: Text('My Classes'),
                // ),
                MyCertificatesScreen(
                  myAssessment: myAssessMentListner.myAssessment,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
