import 'package:athma_kalari_app/features/category/widgets/category_frame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../general/services/custom_image_shimmer.dart';
import '../provider/category_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<void> _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.clearData();

      categoryProvider.fetchAllCategory();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryListner = Provider.of<CategoryProvider>(context);
    return categoryListner.isLoading
        ? const Center(
            child: SizedBox(
              height: 90,
              width: 90,
              child: CustomImageShimmer(),
            ),
          )
        : CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 12,
                ),
              ),
              SliverList.separated(
                itemCount: categoryListner.categoryList.length,
                itemBuilder: (context, index) => CategoryFrame(
                    category: categoryListner.categoryList[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
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
