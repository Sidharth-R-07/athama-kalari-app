import 'dart:developer';

import 'package:athma_kalari_app/features/category/models/category_model.dart';
import 'package:athma_kalari_app/features/sub_category/widgets/sub_category_frame.dart';
import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:athma_kalari_app/general/assets/app_images.dart';
import 'package:athma_kalari_app/general/services/custom_image_shimmer.dart';
import 'package:athma_kalari_app/general/services/custom_lazy_loading.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../general/services/no_data_widget.dart';
import '../provider/sub_category_provider.dart';

class SubCategoryScreen extends StatefulWidget {
  final CategoryModel? category;
  const SubCategoryScreen({super.key, this.category});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final scrollController = ScrollController();
  _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<SubCategoryProvider>(context, listen: false).clearData();
      await Provider.of<SubCategoryProvider>(context, listen: false)
          .fetchAllSubCategory(widget.category!.id!);
    });
  }

  @override
  void initState() {
    _getData();

    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0 &&
          Provider.of<SubCategoryProvider>(context, listen: false)
                  .subCategoryLoading ==
              false &&
          Provider.of<SubCategoryProvider>(context, listen: false)
                  .circularProgressLOading ==
              true) {
        log("MORE DATA CALLED");
        Provider.of<SubCategoryProvider>(context, listen: false)
            .fetchAllSubCategory(widget.category!.id!);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subCategoryListner = Provider.of<SubCategoryProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: Text(
          "${widget.category?.title}",
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: subCategoryListner.isFirebaseDataLoding
          ? const Center(
              child: SizedBox(
                height: 90,
                width: 90,
                child: CustomImageShimmer(),
              ),
            )
          : subCategoryListner.subCategoryList.isEmpty
              ? const NoDataWidget()
              : Container(
                  margin: const EdgeInsets.all(8.0),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverList.separated(
                        itemCount: subCategoryListner.subCategoryList.length,
                        itemBuilder: (context, index) => SubCategoryFrame(
                          categoryId: widget.category!.id!,
                          subCategory:
                              subCategoryListner.subCategoryList[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: (subCategoryListner.circularProgressLOading &&
                                subCategoryListner.isFirebaseDataLoding ==
                                    false)
                            ? const CustomLazyLoading()
                            : Container(),
                      )
                    ],
                  ),
                ),
    );
  }
}
