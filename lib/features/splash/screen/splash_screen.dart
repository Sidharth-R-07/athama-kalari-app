import 'package:athma_kalari_app/features/home/widgets/bottom_bar.dart';
import 'package:athma_kalari_app/general/assets/app_images.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../user/provider/user_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showNext = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUserDetails().whenComplete(() {
        Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
                child: BottomBar(),
                type: PageTransitionType.leftToRightWithFade),
            (route) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.applogo,
              height: 100,
              width: 150,
            ),
          ),
          SizedBox(
            height: 20,
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              pause: const Duration(seconds: 6),
              onNextBeforePause: (p0, p1) {
                setState(() {
                  showNext = true;
                });
              },
              animatedTexts: [
                RotateAnimatedText(
                  '   Athma Learning',
                  textStyle: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                  duration: const Duration(seconds: 1),
                  alignment: Alignment.center,
                  transitionHeight: 25,
                  rotateOut: false,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
            child: Visibility(
              visible: showNext,
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                pause: const Duration(seconds: 6),
                onNextBeforePause: (p0, p1) => true,
                animatedTexts: [
                  RotateAnimatedText(
                    '   Focus Your Athma',
                    textStyle: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                    duration: const Duration(seconds: 2),
                    alignment: Alignment.center,
                    transitionHeight: 25,
                    rotateOut: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
