import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final String? icon;
  final bool? hideDivider;
  const ProfileTab({
    super.key,
    this.onTap,
    this.text,
    this.icon,
    this.hideDivider,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIcon(
                  AssetImage(icon!),
                  size: 20,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  "$text",
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            hideDivider == true
                ? const SizedBox()
                : Divider(
                    color: AppColors.primaryColorLight.withOpacity(0.5),
                    thickness: .5,
                  )
          ],
        ),
      ),
    );
  }
}
