import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool? isPhone;
  final bool? disableFeild;

  const CustomTextFeild({
    super.key,
    this.hintText = '',
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.isPhone = false,
    this.disableFeild = false,
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  FocusNode textFormFieldFocusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    textFormFieldFocusNode.addListener(() {
      if (textFormFieldFocusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textFormFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.disableFeild == true ? false : true,
      focusNode: textFormFieldFocusNode,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
          prefixIcon: widget.isPhone == true
              ? isFocused == true
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text("+91"),
                        ])
                  : const Icon(
                      Icons.phone_iphone_rounded,
                      size: 26,
                      color: AppColors.primaryColor,
                    )
              : null,
          filled: true,
          fillColor: AppColors.bgWhite,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColorLight),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColorLight),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}
