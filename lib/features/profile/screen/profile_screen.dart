import 'dart:developer';

import 'package:athma_kalari_app/features/profile/widgets/profile_tab.dart';
import 'package:athma_kalari_app/features/profile/widgets/select_image_popup.dart';
import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../general/app_details/app_details.dart';
import '../../../general/services/custom_toast.dart';
import '../../authentication/screens/phone_verification_screen.dart';
import '../../user/provider/user_provider.dart';
import '../widgets/logout_dilogue.dart';
import 'profile_edit_screen.dart';
import 'support_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final userListner = Provider.of<UserProvider>(context, listen: true);
    final userData = userListner.userData;
    final currentUser = userListner.currentUser;

    return ColoredBox(
      color: AppColors.bgWhite,
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                color: AppColors.bgGrey,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primaryColorLight,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.bgWhite,
                          backgroundImage: currentUser != null
                              ? userData?.image != null
                                  ? NetworkImage(userData!.image!)
                                  : null
                              : null,
                          child: userListner.imageUploadLoading
                              ? const CupertinoActivityIndicator(
                                  radius: 10,
                                  color: AppColors.primaryColor,
                                )
                              : currentUser == null
                                  ? const Icon(
                                      IconlyBold.profile,
                                      size: 50,
                                      color: AppColors.primaryColor,
                                    )
                                  : userData?.image == null
                                      ? const Icon(
                                          IconlyBold.profile,
                                          size: 50,
                                          color: AppColors.primaryColor,
                                        )
                                      : const SizedBox(),
                        ),
                      ),
                      currentUser != null
                          ? Positioned(
                              bottom: 5,
                              right: 0,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ImageSelectionPopup();
                                    },
                                  );
                                },
                                child: Image.asset(
                                  AppIcons.editProfile,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                  const SizedBox(height: 15),
                  currentUser != null
                      ? Text('${userData?.name}',
                          style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ))
                      : MaterialButton(
                          color: AppColors.bgWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const PhoneVerificationScreen()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                  currentUser != null
                      ? Text('Reg.No : ${userData?.registerNumber}',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                          ))
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileTab(
              text: 'My Courses',
              onTap: () {
                //TODO: Navigate to my courses screen
              },
              icon: AppIcons.profileCourse,
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileTab(
              text: 'Notification',
              icon: AppIcons.profileNotification,
              onTap: () {
                //TODO: Navigate to my courses screen
              },
            ),
          ),
          SliverToBoxAdapter(
            child: currentUser != null
                ? ProfileTab(
                    text: 'Edit Profile',
                    icon: AppIcons.profileEdit,
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          child: const ProfileEditScreen(),
                          type: PageTransitionType.rightToLeftWithFade));
                    },
                  )
                : null,
          ),
          SliverToBoxAdapter(
            child: ProfileTab(
              text: 'Support',
              icon: AppIcons.profileSupport,
              onTap: () {
                Navigator.of(context).push(PageTransition(
                    child: const SupportDetailsScreen(),
                    type: PageTransitionType.rightToLeftWithFade));
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileTab(
              text: 'Share',
              icon: AppIcons.profileShare,
              onTap: () async {
                await Share.share(AppDetails.shareUrl);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileTab(
              text: 'Rates',
              icon: AppIcons.profileRate,
              onTap: () async {
                await launchUrl(Uri.parse(AppDetails.shareUrl));
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileTab(
              text: 'Privacy Policy',
              icon: AppIcons.profilePrivacyPolicy,
              onTap: () {
                //TODO: Navigate to my courses screen
              },
            ),
          ),
          SliverToBoxAdapter(
            child: currentUser != null
                ? ProfileTab(
                    text: 'Logout',
                    icon: AppIcons.profileLogout,
                    onTap: () {
                      showLogoutDilog(context);
                    },
                  )
                : null,
          ),
          SliverToBoxAdapter(
            child: currentUser != null
                ? ProfileTab(
                    text: 'Delete Account',
                    icon: AppIcons.profileDelete,
                    hideDivider: true,
                    onTap: () {
                      //TODO: Navigate to my courses screen
                    },
                  )
                : null,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          )
        ],
      ),
    );
  }
}
