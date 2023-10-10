import 'dart:developer';

import 'package:athma_kalari_app/features/courses/widgets/course_frame.dart';
import 'package:athma_kalari_app/features/home/providers/search_provider.dart';
import 'package:athma_kalari_app/features/sub_category/widgets/sub_category_frame.dart';
import 'package:athma_kalari_app/general/assets/app_lotties.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../general/enums/search_type_enum.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.searchResults.clear();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final seaerchListner = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: TextFormField(
          autofocus: true,
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchController.text = value;
            });
          },
          onFieldSubmitted: (value) {
            searchProvider.getSearchResult(value.trim());
          },
          style: const TextStyle(color: AppColors.black, fontSize: 13),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: 'Search here...',
            hintStyle: TextStyle(color: AppColors.grey, fontSize: 13),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
        actions: [
          searchController.text.trim().isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchController.text = '';
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.grey,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: seaerchListner.searchLoading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AppLotties.searchLoading,
                    height: 80,
                    width: 80,
                  ),
                  const Text(
                    'Searching...',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            )
          : seaerchListner.searchResults.isEmpty
              ? const Center(
                  child: Text(
                    'No result found,Search again...',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 13,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: seaerchListner.searchResults.length,
                  itemBuilder: (context, index) {
                    final item = seaerchListner.searchResults[index];

                    if (item.type == SearchTypeEnum.subcategory) {
                      return SubCategoryFrame(
                        subCategory: item.model,
                      );
                    } else {
                      return CourseFrame(course: item.model);
                    }
                  },
                ),
    );
  }
}
