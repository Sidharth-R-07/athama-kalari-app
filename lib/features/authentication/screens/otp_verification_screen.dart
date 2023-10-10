import 'dart:developer';

import 'package:athma_kalari_app/features/authentication/providers/auth_provider.dart';
import 'package:athma_kalari_app/features/authentication/widgets/otp_form.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../general/assets/app_images.dart';
import '../../../general/utils/app_colors.dart';
import 'timer_count_down.dart';

class OtpVerificationSccreen extends StatefulWidget {
  final String phone;
  const OtpVerificationSccreen({super.key, required this.phone});

  @override
  State<OtpVerificationSccreen> createState() => _OtpVerificationSccreenState();
}

class _OtpVerificationSccreenState extends State<OtpVerificationSccreen> {
  final TextEditingController otp1 = TextEditingController();

  final TextEditingController otp2 = TextEditingController();

  final TextEditingController otp3 = TextEditingController();

  final TextEditingController otp4 = TextEditingController();

  final TextEditingController otp5 = TextEditingController();

  final TextEditingController otp6 = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool showOtpError = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.clearData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authListner = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.1),
          ),
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.03),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Image.asset(
                AppImages.otpVerification,
                height: 200,
                width: 250,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.03),
          ),
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                "We send a OTP on your Registered\n Number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.03),
          ),

          // OTP Form
          SliverToBoxAdapter(
            child: OtpForm(
              otp1: otp1,
              otp2: otp2,
              otp3: otp3,
              otp4: otp4,
              otp5: otp5,
              otp6: otp6,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.01),
          ),
          if (showOtpError)
            SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * 0.1),
                  const Text(
                    "Please enter a valid OTP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.01),
          ),
          const SliverToBoxAdapter(
            child: CountDownTimer(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.03),
          ),
          SliverToBoxAdapter(
              child: Consumer<AuthProvider>(
            builder: (context, authListner, _) => Center(
              child: MaterialButton(
                color: authListner.veryfyOtpLoading
                    ? AppColors.primaryColor.withOpacity(.7)
                    : AppColors.primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minWidth: size.width * 0.5,
                height: 42,
                onPressed: () {
                  if (authListner.veryfyOtpLoading == false) {
                    _veryFn();
                  }
                },
                child: authListner.veryfyOtpLoading
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
                            'Verifying...',
                            style: TextStyle(
                              color: AppColors.primaryColorLight,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        "Verify",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: SizedBox(height: size.height * 0.03),
          ),
          SliverToBoxAdapter(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Didn't receive the OTP?",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              TextButton(
                onPressed: authListner.showResendOtp == true
                    ? () {
                        _resendOtp();
                      }
                    : null,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: authListner.showResendOtp == true
                        ? AppColors.red
                        : AppColors.grey,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  void _veryFn() {
    if (otp1.text.isEmpty ||
        otp2.text.isEmpty ||
        otp3.text.isEmpty ||
        otp4.text.isEmpty ||
        otp5.text.isEmpty ||
        otp6.text.isEmpty) {
      setState(() {
        showOtpError = true;
      });
      return;
    }

    log("OTP: ${otp1.text}${otp2.text}${otp3.text}${otp4.text}${otp5.text}${otp6.text}");
    setState(() {
      showOtpError = false;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.verifyOtp(
      phoneNumber: widget.phone,
      otp:
          "${otp1.text}${otp2.text}${otp3.text}${otp4.text}${otp5.text}${otp6.text}",
      context: context,
    );
  }

  void _resendOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.resendCode(widget.phone).whenComplete(() {
      CustomToast.successToast(message: 'Code Sent Successfully');
    });
  }
}
