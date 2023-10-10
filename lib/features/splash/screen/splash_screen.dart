import 'package:athma_kalari_app/features/home/widgets/bottom_bar.dart';
import 'package:athma_kalari_app/general/assets/app_icons.dart';
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
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUserDetails().whenComplete(() {
        Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
                child: const BottomBar(),
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
            height: 25,
            child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                RotateAnimatedText(
                  '   Athma Learning',
                  textStyle: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                  alignment: Alignment.center,
                  transitionHeight: 50,
                ),
                RotateAnimatedText(
                  '   Focus Your Athma',
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
