import 'package:athma_kalari_app/features/category/models/category_model.dart';
import 'package:athma_kalari_app/features/sub_category/screens/sub_category_screen.dart';
import 'package:athma_kalari_app/general/services/custom_cached_network_image.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CategoryFrame extends StatelessWidget {
  final CategoryModel category;
  const CategoryFrame({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: SubCategoryScreen(category: category),
            type: PageTransitionType.rightToLeftWithFade));
      },
      child: Container(
        height: 260,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomCachedNetworkImage(
                imageUrl: category.image!,
                height: 185,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              category.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${category.groups == null ? 0 : category.groups?.length} Groups",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
