import 'package:athma_kalari_app/features/profile/widgets/custom_text_feild.dart';
import 'package:athma_kalari_app/general/enums/enquiry_status_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../general/assets/app_icons.dart';
import '../../../general/services/build_search_keywords.dart';
import '../../../general/services/text_feild_validation.dart';
import '../../../general/utils/app_colors.dart';
import '../../authentication/widgets/gender_selection_dropdown.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_provider.dart';
import '../widgets/select_image_popup.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool isNotSelected = false;
  Gender getGender = Gender.select;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final addressController = TextEditingController();

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAndSetData();
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    bloodGroupController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userListner = Provider.of<UserProvider>(context, listen: true);
    final userData = userListner.userData;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: AppColors.bgGrey,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.primaryColorLight,
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: AppColors.bgWhite,
                              backgroundImage: userData?.image != null
                                  ? NetworkImage(userData!.image!)
                                  : null,
                              child: userListner.imageUploadLoading
                                  ? const CupertinoActivityIndicator(
                                      radius: 10,
                                      color: AppColors.primaryColor,
                                    )
                                  : userData?.image != null
                                      ? const SizedBox.shrink()
                                      : const Icon(
                                          IconlyBold.profile,
                                          size: 50,
                                          color: AppColors.primaryColor,
                                        ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 0,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ImageSelectionPopup();
                                  },
                                );
                              },
                              child: Image.asset(
                                AppIcons.editProfile,
                                height: 25,
                                width: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text('${userData?.name}',
                          style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        'Reg.No : ${userData?.registerNumber}',
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              const SliverToBoxAdapter(child: Text('   Name')),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 4,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextFeild(
                  controller: nameController,
                  hintText: 'Enter your name',
                  validator: validateName,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              const SliverToBoxAdapter(child: Text('   Phone Number')),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 4,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextFeild(
                  hintText: 'Enter your Number',
                  controller: phoneController,
                  isPhone: true,
                  disableFeild: true,
                  validator: validatePhone,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.0,
                ),
              ),
              const SliverToBoxAdapter(child: Text('   Blood Group')),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 4.0,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextFeild(
                  controller: bloodGroupController,
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
                  controller: addressController,
                  textInputAction: TextInputAction.done,
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
                //SUBMIT FUNCTION

                _submitFn(userData!);
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
                    'Save',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void fetchAndSetData() {
    final userListner = Provider.of<UserProvider>(context, listen: false);
    final userData = userListner.userData;
    nameController.text = userData?.name ?? '';
    phoneController.text = userData?.phoneNumber ?? '';
    bloodGroupController.text = userData?.bloodGroup ?? '';
    addressController.text = userData?.address ?? '';

    

    switch (userData?.gender) {
      case "male":
        getGender = Gender.male;
        break;
      case "female":
        getGender = Gender.female;
        break;
      default:
        getGender = Gender.select;
        break;
    }
    setState(() {});
  }

  void _submitFn(UserModel userData) async {
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

    final newUser = UserModel(
      address: addressController.text,
      bloodGroup: bloodGroupController.text,
      gender: getGender.name,
      name: nameController.text,
      keywords: keywordsBuilder(nameController.text),
      id: userData.id,
      registerNumber: userData.registerNumber,
      phoneNumber: userData.phoneNumber,
      image: userData.image,
      createdAt: userData.createdAt,
      fcmToken: userData.fcmToken,
      myCourses: userData.myCourses,
      subSCriptionCourses: userData.subSCriptionCourses,
    );

    await userProvider.updateUserData(newUser);
  }
}
