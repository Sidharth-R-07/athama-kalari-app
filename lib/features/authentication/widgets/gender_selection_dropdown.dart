import 'package:athma_kalari_app/general/enums/enquiry_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../general/utils/app_colors.dart';

class GenderSelectionDrpDown extends StatefulWidget {
  GenderSelectionDrpDown({
    super.key,
    this.selectedValue = Gender.other,
    this.isNotSelected = false,
    this.onChanged,
  });
  Gender selectedValue;
  bool isNotSelected;
  final Function(Gender?)? onChanged;

  @override
  State<GenderSelectionDrpDown> createState() => _GenderSelectionDrpDownState();
}

class _GenderSelectionDrpDownState extends State<GenderSelectionDrpDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        border: Border.all(
          color: widget.isNotSelected
              ? AppColors.red
              : AppColors.primaryColorLight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Gender>(
          value: widget.selectedValue,
          items: const [
            DropdownMenuItem(
              value: Gender.select,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Choose Gender',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: Gender.male,
              child: Text(
                'Male',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            DropdownMenuItem(
              value: Gender.female,
              child: Text(
                'Female',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            DropdownMenuItem(
              value: Gender.other,
              child: Text(
                'Other',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          onChanged: widget.onChanged,
          icon: const Icon(IconlyLight.arrow_down_2),
          dropdownColor: AppColors.bgWhite,
          iconSize: 20,
          isExpanded: true,
          elevation: 1,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
