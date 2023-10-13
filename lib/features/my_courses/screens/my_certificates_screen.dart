import 'package:athma_kalari_app/features/assessment/provider/assessment_provider.dart';
import 'package:athma_kalari_app/general/services/athma_loading.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:provider/provider.dart';

import '../../assessment/widgets/active_assessment_frame.dart';

class MyCertificatesScreen extends StatelessWidget {
  List<AssessmentModel>? myAssessment;
  MyCertificatesScreen({
    Key? key,
    this.myAssessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assessmentListner =
        Provider.of<AssessmentProvider>(context, listen: true);
    return assessmentListner.initailLoading
        ? const Center(
            child: AthmaLoading(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: CustomScrollView(slivers: [
              const SliverToBoxAdapter(
                child: Text(
                  "Active Assessments",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              myAssessment!.isEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: AppColors.bgWhite,
                        child: const Center(
                          child: Text("No active assessment yet!"),
                        ),
                      ),
                    )
                  : SliverList.separated(
                      itemCount: myAssessment?.length,
                      itemBuilder: (context, index) => ActiveAssessmentFrame(
                          assessment: myAssessment![index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10))
            ]),
          );
  }
}
