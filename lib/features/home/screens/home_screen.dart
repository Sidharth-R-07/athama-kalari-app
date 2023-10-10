import 'dart:developer';

import 'package:athma_kalari_app/features/category/provider/category_provider.dart';
import 'package:athma_kalari_app/features/courses/provider/course_provider.dart';
import 'package:athma_kalari_app/features/courses/widgets/course_frame.dart';
import 'package:athma_kalari_app/features/home/screens/search_screen.dart';
import 'package:athma_kalari_app/features/home/widgets/home_category_frame.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../general/services/custom_lazy_loading.dart';
import '../../my_courses/widgets/my_course_frame.dart';
import '../../user/provider/user_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/introduction_video_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollcontroller = ScrollController();
  _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.fetchAllCategory();
      final courseProvider =
          Provider.of<CourseProvider>(context, listen: false);
      courseProvider.clearData();
      courseProvider.fetchAllCourses();
    });
  }

  @override
  void initState() {
    _getData();

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.atEdge &&
          scrollcontroller.position.pixels != 0 &&
          Provider.of<CourseProvider>(context, listen: false).courseLoading ==
              false &&
          Provider.of<CourseProvider>(context, listen: false)
                  .circularProgressLOading ==
              true) {
        Provider.of<CourseProvider>(context, listen: false).fetchAllCourses();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryListner = Provider.of<CategoryProvider>(context);
    final courseListner = Provider.of<CourseProvider>(context);
    final userCourses =
        Provider.of<UserProvider>(context).userData?.subSCriptionCourses;
    return CustomScrollView(
      controller: scrollcontroller,
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.bgWhite,
          surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
          snap: true,
          floating: true,
          title: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).push(PageTransition(
                  child: const SearchScreen(),
                  type: PageTransitionType.rightToLeftWithFade));
            },
            child: Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: AppColors.primaryColorLight, width: .4)),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search here',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Icon(
                    IconlyLight.search,
                    color: AppColors.grey,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
        ),

        //INTRODUCTION VIDEO
        const SliverToBoxAdapter(
            child: IntroductionVideoContainer(
          videoUrl: 'https://youtu.be/jl11HVWI6mE?si=Wt7YX_BwPGxwRwPE',
          title: "Athma Kalari",
          subTitle: "Introduction",
        )),

        const SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),

        //BANNER SECTION
        const SliverToBoxAdapter(
          child: BannerImageSlider(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),
        //CATEGORY SECTION
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Categories',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: categoryListner.categoryList.isEmpty
                  ? 3
                  : categoryListner.categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => HomeCategoryFrame(
                  category: categoryListner.categoryList.isEmpty
                      ? null
                      : categoryListner.categoryList[index]),
            ),
          ),
        ),

        //NEWLY COURSE SECTION

        const SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'New Courses',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 12),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverList.separated(
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
              return CourseFrame(course: courseListner.courseList[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        ),

        SliverToBoxAdapter(
          child: (courseListner.circularProgressLOading &&
                  courseListner.isFirebaseDataLoding == false)
              ? const CustomLazyLoading()
              : Container(),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 70),
        ),
      ],
    );
  }
}
