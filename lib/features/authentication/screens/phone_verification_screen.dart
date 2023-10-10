import 'dart:developer';

import 'package:athma_kalari_app/features/authentication/providers/auth_provider.dart';
import 'package:athma_kalari_app/general/assets/app_images.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:athma_kalari_app/general/services/text_feild_validation.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../profile/widgets/custom_text_feild.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  bool isChecked = false;
  final formkey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  bool veryfyPhoneLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.primaryColorLight,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: size.height * 0.05,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppImages.athmaIcon,
                height: size.height * 0.25,
                width: size.width * 0.25,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.5,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),

          //----------------------------LOGIN CONTAINER----------------
          Positioned(
            top: size.height * 0.3,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: AppColors.bgWhite,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      )
                    ]),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppImages.loginText,
                          height: 32,
                          width: 80,
                        ),
                        const SizedBox(height: 15),
                        const Text('   Number'),
                        const SizedBox(height: 10),
                        CustomTextFeild(
                          hintText: 'Enter your number',
                          isPhone: true,
                          keyboardType: TextInputType.phone,
                          validator: validatePhone,
                          controller: phoneController,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: isChecked,
                                onChanged: (val) {
                                  setState(() {
                                    isChecked = val!;
                                  });
                                }),
                            const Expanded(
                              child: Text(
                                  'By continuing you agree to our terms conditions and privacy policy.',
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Consumer<AuthProvider>(
                          builder: (context, authListner, _) => MaterialButton(
                            minWidth: double.infinity,
                            height: 40,
                            color: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              if (authListner.veryfyPhoneLoading == false) {
                                _verifyFn(authProvider);
                              }
                            },
                            child: authListner.veryfyPhoneLoading == true
                                ? const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CupertinoActivityIndicator(
                                          color: AppColors.primaryColorLight,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Please wait...',
                                        style: TextStyle(
                                          color: AppColors.primaryColorLight,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Get Verify',
                                    style: TextStyle(
                                      color: AppColors.bgWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _verifyFn(AuthProvider authProvider) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      log('not valid');
      return;
    }
    if (!isChecked) {
      CustomToast.errorToast(
          message: 'Please agree to our terms and conditions');
      return;
    }
    await authProvider.veryPhoneNumber(
        context: context, phoneNumber: phoneController.text);
  }
}
