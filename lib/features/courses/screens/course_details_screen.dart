import 'package:athma_kalari_app/features/authentication/screens/phone_verification_screen.dart';
import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:athma_kalari_app/features/courses/widgets/bullet_point.dart';
import 'package:athma_kalari_app/features/courses/widgets/lesson_frame.dart';
import 'package:athma_kalari_app/features/home/widgets/introduction_video_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import '../../../general/assets/app_icons.dart';
import '../../../general/services/dynamic_link_services.dart';
import '../../../general/utils/app_colors.dart';
import '../../my_courses/providers/my_courses_provider.dart';
import '../../user/provider/user_provider.dart';

class CourseDetailsScreen extends StatefulWidget {
  final CourseModel course;
  const CourseDetailsScreen({super.key, required this.course});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  @override
  void initState() {
    tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myCourseListner =
        Provider.of<MyCourseProvider>(context, listen: true);

    final userListner = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: Text(
          "${widget.course.title}",
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              DynamicLinkServices.createDynamicLink(widget.course.id!)
                  .then((value) {
                Share.share(
                  value,
                  subject: 'Check out this course',
                );
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Image.asset(
              AppIcons.shareIcon,
              height: 20,
              width: 20,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: true,
            automaticallyImplyLeading: false,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: IntroductionVideoContainer(
                  videoUrl: widget.course.videoLink!),
            ),
          ),

          //COURSE DETAILS
          SliverFillRemaining(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.course.title}",
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height:
                          (30 * widget.course.bulletPoints!.length.toDouble()),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.course.bulletPoints!.length,
                        itemBuilder: (context, index) => BulletPoint(
                          text: widget.course.bulletPoints![index],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TabBar(
                      dividerColor: AppColors.bgWhite,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4,
                      controller: tabcontroller,
                      tabs: const [
                        Tab(
                          child: Text(
                            "About",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Lessons",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        controller: tabcontroller,
                        children: [
                          _AboutTab(course: widget.course),
                          _LessonsTab(course: widget.course),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
            ),
          )
        ],
      ),

      //BOTTOM BAR
      bottomSheet: Container(
        height: 70,
        width: double.infinity,
        color: AppColors.bgGrey,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹ ${widget.course.courseFee}",
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "${widget.course.lessons!.length}",
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
                ],
              ),
            ),
            MaterialButton(
              onPressed: myCourseListner.addingCourseLoading == false
                  ? () {
                      //ADD COURSE
                      if (userListner.currentUser == null) {
                        Navigator.of(context).push(PageTransition(
                            child: const PhoneVerificationScreen(),
                            type: PageTransitionType.bottomToTop));
                      } else {
                        myCourseListner.addCourse(
                          course: widget.course,
                          registerNumber: userListner.userData!.registerNumber!,
                        );
                      }
                    }
                  : () {},
              color: AppColors.primaryColor,
              minWidth: 130,
              height: 45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: myCourseListner.addingCourseLoading
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CupertinoActivityIndicator(
                            color: AppColors.primaryColorLight,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Buying...',
                          style: TextStyle(
                            color: AppColors.primaryColorLight,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      "Buy Now",
                      style: TextStyle(
                        color: AppColors.bgWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  final CourseModel course;
  const _AboutTab({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      "${course.aboutCourse}",
      trimLines: 8,
      colorClickableText: AppColors.primaryColor,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'show more',
      trimExpandedText: ' show less',
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      moreStyle: const TextStyle(
        color: AppColors.primaryColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
      lessStyle: const TextStyle(
        color: AppColors.primaryColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _LessonsTab extends StatelessWidget {
  final CourseModel course;
  const _LessonsTab({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lessons (${course.lessons!.length})",
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: course.lessons!.length,
              itemBuilder: (context, index) => LessonFrame(
                lesson: course.lessons![index],
                index: index,
              ),
            ),
          )
        ]);
  }
}

const String loremIpus =
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
