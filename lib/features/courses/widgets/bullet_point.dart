import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:flutter/cupertino.dart';

class BulletPoint extends StatelessWidget {
  final String? text;
  const BulletPoint({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(AppIcons.bulletPoint, height: 15, width: 15),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff4F4F4F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
