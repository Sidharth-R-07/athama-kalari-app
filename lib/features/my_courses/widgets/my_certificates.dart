// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';

import 'active_assessment_frame.dart';

class MyCertificatesScreen extends StatelessWidget {
  List<AssessmentModel>? myAssessment;
  MyCertificatesScreen({
    Key? key,
    this.myAssessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        SliverList.separated(
            itemCount: 12,
            itemBuilder: (context, index) => const ActiveAssessmentFrame(),
            separatorBuilder: (context, index) => const SizedBox(height: 10))
      ]),
    );
  }
}
