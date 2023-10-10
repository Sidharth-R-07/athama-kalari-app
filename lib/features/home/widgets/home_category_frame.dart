import 'package:athma_kalari_app/features/category/models/category_model.dart';
import 'package:athma_kalari_app/features/category/provider/category_provider.dart';
import 'package:athma_kalari_app/features/sub_category/screens/sub_category_screen.dart';
import 'package:athma_kalari_app/general/services/custom_cached_network_image.dart';
import 'package:athma_kalari_app/general/services/custom_image_shimmer.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeCategoryFrame extends StatelessWidget {
  final CategoryModel? category;
  const HomeCategoryFrame({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final categoryListner = Provider.of<CategoryProvider>(context);
    return InkWell(
      onTap: () {
        categoryListner.selectedCategory = category;
        Navigator.of(context).push(PageTransition(
            child: SubCategoryScreen(category: category),
            type: PageTransitionType.rightToLeftWithFade));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: 130,
        height: 148,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.bgGrey, width: .4),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child:
            (categoryListner.isLoading || categoryListner.categoryList.isEmpty)
                ? const Center(
                    child: CustomImageShimmer(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomCachedNetworkImage(
                          width: double.infinity,
                          height: 100,
                          imageUrl: category!.image!,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              category!.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${category!.groups == null ? 0 : category!.groups?.length} Groups",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
      ),
    );
  }
}
