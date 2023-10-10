import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SearchFeild extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onsubmit;
  final Function(String)? onchange;
  const SearchFeild(
      {super.key,
      this.controller,
      this.hintText = "Search Here",
      this.onsubmit,
      this.onchange});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        onFieldSubmitted: onsubmit,
        onChanged: onchange,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          suffixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.primaryColor,
            size: 26,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: .2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: .6),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: .8),
          ),
          filled: true,
          fillColor: AppColors.bgWhite,
        ),
      ),
    );
  }
}
