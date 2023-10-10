import 'dart:developer';

import 'package:athma_kalari_app/features/user/provider/user_provider.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/providers/auth_provider.dart';

void showLogoutDilog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.70),
    transitionDuration: const Duration(milliseconds: 120),
    pageBuilder: (context, _, __) {
      return Center(
        child: Container(
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: SizedBox.expand(
              child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            shadowColor: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, setState) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Are you sure you want to Logout?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap:
                              Provider.of<AuthProvider>(context).logoutLoading
                                  ? null
                                  : () {
                                      Navigator.of(context).pop();
                                    },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.bgGrey,
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).pop();
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .logoutUser(context)
                                .then((value) {
                              if (value) {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .clearData();
                              } else {
                                log("LOGOUT FAILD !");
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.primaryColor,
                            ),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.bgWhite,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
      );
    },
    transitionBuilder: (___, anim, _, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
