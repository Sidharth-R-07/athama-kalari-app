import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLazyLoading extends StatelessWidget {
  const CustomLazyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            radius: 10,
            animating: true,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Loading...",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
          )
        ],
      ),
    ));
  }
}
