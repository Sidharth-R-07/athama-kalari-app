import 'package:athma_kalari_app/features/authentication/widgets/gender_selection_dropdown.dart';
import 'package:athma_kalari_app/features/profile/widgets/custom_text_feild.dart';
import 'package:athma_kalari_app/features/user/model/user_model.dart';
import 'package:athma_kalari_app/general/enums/enquiry_status_enum.dart';
import 'package:athma_kalari_app/general/services/athma_loading.dart';
import 'package:athma_kalari_app/general/services/build_search_keywords.dart';
import 'package:athma_kalari_app/general/services/text_feild_validation.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user/provider/user_provider.dart';

class AddUserDetailsScreen extends StatefulWidget {
  final String? phoneNumber;
  const AddUserDetailsScreen({super.key, this.phoneNumber});

  @override
  State<AddUserDetailsScreen> createState() => _AddUserDetailsScreenState();
}

class _AddUserDetailsScreenState extends State<AddUserDetailsScreen> {
  Gender getGender = Gender.select;
  bool isNotSelected = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _registerNumberController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _addressController = TextEditingController();

  _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      int? registerNumber = await userProvider.getRegisterNumber(context);

      _registerNumberController.text = registerNumber.toString();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _registerNumberController.dispose();
    _bloodGroupController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userListner = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
        body: userListner.isLoading == true
            ? const AthmaLoading()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: size.height * 0.08,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Text(
                          'Enter your Details',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      const SliverToBoxAdapter(child: Text('   Name')),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 8.0,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: CustomTextFeild(
                          controller: _nameController,
                          hintText: 'Enter your name',
                          validator: validateName,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      const SliverToBoxAdapter(
                          child: Text('   Register Number')),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 8.0,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: CustomTextFeild(
                          controller: _registerNumberController,
                          disableFeild: true,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      const SliverToBoxAdapter(child: Text('   Blood Group')),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 8.0,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: CustomTextFeild(
                          controller: _bloodGroupController,
                          hintText: 'Enter your Blood Group',
                          validator: validateBloodGroup,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      const SliverToBoxAdapter(child: Text('   Gender')),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 8.0,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: GenderSelectionDrpDown(
                          selectedValue: getGender,
                          isNotSelected: isNotSelected,
                          onChanged: (Gender? newValue) {
                            setState(() {
                              getGender = newValue!;
                            });
                          },
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      const SliverToBoxAdapter(child: Text('   Adress')),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 8.0,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: CustomTextFeild(
                          textInputAction: TextInputAction.done,
                          controller: _addressController,
                          hintText: 'Enter your Address',
                          maxLines: 3,
                          validator: validateAddress,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: size.height * 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomSheet: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: AppColors.primaryColor,
              minWidth: size.width * 0.9,
              height: 42,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                if (userListner.addLoading == false) {
                  _submitFn();
                }
              },
              child: userListner.addLoading
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
                      'Lets Continue',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ));
  }

  void _submitFn() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      getGender.index == 0 ? isNotSelected = true : isNotSelected = false;
    });

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (isNotSelected) {
      return;
    }

    await FirebaseMessaging.instance.subscribeToTopic('allUsers');
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final newUser = UserModel(
      address: _addressController.text,
      bloodGroup: _addressController.text,
      gender: getGender.name,
      name: _nameController.text,
      registerNumber: _registerNumberController.text,
      createdAt: Timestamp.now(),
      keywords: keywordsBuilder(_nameController.text),
      phoneNumber: widget.phoneNumber,
      fcmToken: fcmToken,
      id: FirebaseAuth.instance.currentUser?.uid,
    );

    await userProvider.storeUserData(newUser).then((value) {
      if (value == true) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        return;
      }
    }).whenComplete(() {
      _addressController.clear();
      _bloodGroupController.clear();
      _nameController.clear();
      _registerNumberController.clear();
    });
  }
}
