import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  final VoidCallback? onExist;
  const ExitConfirmationDialog({Key? key, this.onExist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bgWhite,
      title: const Text('Exit Confirmation',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
      content: const Text('Are you sure you want to exit this assessment?',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          )),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
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
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Dismiss the dialog with a 'false' result.
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
