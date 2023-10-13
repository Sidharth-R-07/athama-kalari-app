import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/assessment_provider.dart';

class SubmitAssessmentDialog extends StatelessWidget {
  final VoidCallback? onSubmit;
  const SubmitAssessmentDialog({Key? key, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assessmentListner = Provider.of<AssessmentProvider>(context);
    return AlertDialog(
      backgroundColor: AppColors.bgWhite,
      title: const Text('Submit Assessment',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
      content: const Text('Are you sure you want to Submit this assessment?',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          )),
      actions: <Widget>[
        MaterialButton(
          onPressed: assessmentListner.addAssessmentLoading ? () {} : onSubmit,
          height: 30,
          minWidth: 70,
          color: AppColors.primaryColor,
          textColor: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppColors.primaryColorLight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          elevation: 0,
          child: assessmentListner.addAssessmentLoading
              ? const CupertinoActivityIndicator(
                  radius: 10,
                  color: AppColors.primaryColorLight,
                )
              : const Text('Submit'),
        ),
        TextButton(
          onPressed: assessmentListner.addAssessmentLoading
              ? null
              : () {
                  Navigator.of(context).pop(false);
                },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
