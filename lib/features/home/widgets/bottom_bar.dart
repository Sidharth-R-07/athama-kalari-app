// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:athma_kalari_app/features/notification/screen/notification_screen.dart';
import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';

import '../../../general/assets/app_images.dart';
import '../../../general/services/dynamic_link_services.dart';
import '../../category/screens/category_screen.dart';
import '../../my_courses/screens/my_courses_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  int? currentIndex;
  BottomBar({
    Key? key,
    this.currentIndex,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const MyCoursesScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      
      setState(() {
        currentIndex = widget.currentIndex ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DynamicLinkServices.handleDynamicLinks();
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.athmaIcon,
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Athma Kalari',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        // actions: [
        //   currentIndex == 0
        //       ? InkWell(
        //           splashColor: Colors.transparent,
        //           highlightColor: Colors.transparent,
        //           onTap: () {
        //             setState(() {
        //               currentIndex = 3;
        //             });
        //           },
        //           child: Image.asset(
        //             AppIcons.appBarNotification,
        //             height: 26,
        //             width: 26,
        //           ),
        //         )
        //       : const SizedBox.shrink(),
        //   const SizedBox(
        //     width: 10,
        //   )
        // ],
      ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        child: const ImageIcon(
          AssetImage(AppIcons.floatingIcon),
          color: AppColors.bgWhite,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                  child: ImageIcon(
                    AssetImage(
                      currentIndex == 0
                          ? AppIcons.homeSelected
                          : AppIcons.homeUnselected,
                    ),
                    color: currentIndex == 0
                        ? AppColors.primaryColor
                        : AppColors.black,
                    size: currentIndex == 0 ? 18 : 20,
                  ),
                ),
                const SizedBox(width: 10),
                MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                  child: ImageIcon(
                    AssetImage(
                      currentIndex == 1
                          ? AppIcons.categorySelected
                          : AppIcons.categoryUnselected,
                    ),
                    color: currentIndex == 1
                        ? AppColors.primaryColor
                        : AppColors.black,
                    size: currentIndex == 1 ? 18 : 20,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  minWidth: 40,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                  child: ImageIcon(
                    AssetImage(
                      currentIndex == 3
                          ? AppIcons.notificationSelected
                          : AppIcons.notificationUnselected,
                    ),
                    color: currentIndex == 3
                        ? AppColors.primaryColor
                        : AppColors.black,
                    size: currentIndex == 3 ? 18 : 20,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  },
                  child: ImageIcon(
                    AssetImage(
                      currentIndex == 4
                          ? AppIcons.profileSelected
                          : AppIcons.profileUnselected,
                    ),
                    color: currentIndex == 4
                        ? AppColors.primaryColor
                        : AppColors.black,
                    size: currentIndex == 4 ? 18 : 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
