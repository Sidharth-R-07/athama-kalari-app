import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/notification_frame.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 12,
          ),
        ),
        SliverList.separated(
          itemCount: 10,
          itemBuilder: (context, index) => const NotificationFrame(),
          separatorBuilder: (context, index) => const Divider(
            thickness: 0.3,
            color: AppColors.primaryColorLight,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 60,
          ),
        ),
      ],
    );
  }
}
