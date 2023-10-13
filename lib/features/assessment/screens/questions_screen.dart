import 'dart:async';
import 'dart:developer';

import 'package:athma_kalari_app/features/assessment/models/assessment_model.dart';
import 'package:athma_kalari_app/features/assessment/screens/assessment_completed_screen.dart';
import 'package:athma_kalari_app/features/assessment/screens/assessment_countdown_screen.dart';
import 'package:athma_kalari_app/features/assessment/widgets/submit_assessment_dilogue.dart';
import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../general/utils/app_colors.dart';
import '../widgets/exist_assessment_dilogue.dart';
import '../provider/assessment_provider.dart';

class QuestionsScreen extends StatefulWidget {
  final AssessmentModel? assessment;
  const QuestionsScreen({
    super.key,
    required this.assessment,
  });

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final answerController = TextEditingController();
  late AssessmentProvider assessmentProvider;

  Timer? timer;
  int currentCount = 0;

  int minutes = 1; // Set the initial number of minutes
  int seconds = 0; // Set the initial number of seconds
  @override
  void initState() {
    assessmentProvider =
        Provider.of<AssessmentProvider>(context, listen: false);
    _fetchAndSetQuestions();
    super.initState();
  }

  @override
  void dispose() {
    answerController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assessmentListner =
        Provider.of<AssessmentProvider>(context, listen: true);

    if (assessmentListner.currentQuestion?.answer != null) {
      answerController.text = assessmentListner.currentQuestion!.answer!;
      setState(() {});
    } else {
      answerController.text = "";
      setState(() {});
    }

    return WillPopScope(
      onWillPop: () async {
        final exitConfirmed = await showDialog(
          context: context,
          builder: (context) => const ExitConfirmationDialog(),
        );

        return exitConfirmed ?? false;
      },
      child: Scaffold(
        backgroundColor: AppColors.bgGrey,
        appBar: AppBar(
          backgroundColor: AppColors.bgWhite,
          surfaceTintColor: AppColors.bgWhite,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () async {
              final exitConfirmed = await showDialog(
                context: context,
                builder: (context) => const ExitConfirmationDialog(),
              );

              if (exitConfirmed ?? false) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              IconlyLight.arrow_left,
              color: AppColors.primaryColor,
            ),
          ),
          elevation: 0,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          title: const Text(
            "Assessment",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question  ${assessmentListner.currentQuestionIndex + 1} / ${assessmentListner.questions.length}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "$minutes:${seconds}s  ",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppIcons.questionMark,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        "${assessmentListner.currentQuestion?.question}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: answerController,
                  maxLines: 16,
                  decoration: InputDecoration(
                    fillColor: AppColors.bgWhite,
                    filled: true,
                    hintText: "Write your answer here",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.bgGrey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.bgGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.bgGrey,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    assessmentProvider.currentQuestion?.answer = value;
                  },
                  onSaved: (newValue) {
                    assessmentProvider.currentQuestion?.answer = newValue;
                  },
                ),
              )
            ],
          ),
        ),
        bottomSheet: Container(
          color: AppColors.bgGrey,
          height: 55,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              assessmentListner.currentQuestionIndex != 0
                  ? MaterialButton(
                      height: 30,
                      minWidth: 100,
                      color: AppColors.bgWhite,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      onPressed: () {
                        //PREVIOUS QUESTION
                        _saveAnswer();
                        assessmentProvider.previousQuestion();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconlyLight.arrow_left_2,
                            size: 16,
                            color: AppColors.primaryColor,
                          ),
                          Text(
                            "Previous",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              MaterialButton(
                height: 30,
                minWidth: 100,
                color: (assessmentListner.currentQuestionIndex + 1) ==
                        widget.assessment?.assessmentDteails?.questionsCount
                    ? AppColors.primaryColor
                    : AppColors.bgWhite,
                textColor: (assessmentListner.currentQuestionIndex + 1) ==
                        widget.assessment?.assessmentDteails?.questionsCount
                    ? AppColors.bgWhite
                    : AppColors.textColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                onPressed: (assessmentListner.currentQuestionIndex + 1) ==
                        widget.assessment?.assessmentDteails?.questionsCount
                    ? () {
                        //SUBMIT ANSWER
                        showDialog(
                          context: context,
                          builder: (context) =>
                              SubmitAssessmentDialog(onSubmit: () {
                            final attemptedList = assessmentProvider.questions
                                .where((element) => element.answer != null)
                                .toList();

                            final newAssessment = AssessmentModel(
                              assessmentDteails:
                                  widget.assessment?.assessmentDteails,
                              attemptsQuestion: attemptedList.length,
                              totalAttempts:
                                  widget.assessment?.totalAttempts ?? 0 + 1,
                              isSubmitted: true,
                              questions: assessmentListner.questions,
                              id: widget.assessment?.id,
                              courseId: widget.assessment?.courseId,
                              courseName: widget.assessment?.courseName,
                              userId: widget.assessment?.userId,
                              userName: widget.assessment?.userName,
                              courseLessons: widget.assessment?.courseLessons,
                              createdAt: Timestamp.now(),
                              registerNumber: widget.assessment?.registerNumber,
                              totalQuestions: widget.assessment
                                  ?.assessmentDteails?.questionsCount,
                              reTake: null,
                              isPassed: null,
                            );
                            assessmentProvider
                                .submitAssessment(newAssessment)
                                .then((value) {
                              if (value) {
                                log("ASSESSMENT SUBMITTED SUCCESSFULLY11111");

                                Navigator.of(context).push(PageTransition(
                                    child: const AssessmentCompletedScreen(),
                                    type: PageTransitionType.fade));
                              } else {
                                log("ERROR IN SUBMIT ASSESSMENT");

                                CustomToast.errorToast(
                                    message: "Error in submit assessment");
                              }
                            });
                          }),
                        );
                      }
                    : () {
                        //NEXT QUESTION
                        _saveAnswer();
                        assessmentProvider.nextQuestion();
                      },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (assessmentListner.currentQuestionIndex + 1) ==
                              widget
                                  .assessment?.assessmentDteails?.questionsCount
                          ? "Submit"
                          : "Next",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    (assessmentListner.currentQuestionIndex + 1) ==
                            widget.assessment?.assessmentDteails?.questionsCount
                        ? const SizedBox.shrink()
                        : const Icon(
                            IconlyLight.arrow_right_2,
                            size: 16,
                            color: AppColors.primaryColor,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchAndSetQuestions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final assessmentProvider =
          Provider.of<AssessmentProvider>(context, listen: false);
      assessmentProvider.getRandomItems(
          widget.assessment!.assessmentDteails!.questionsCount!);
      minutes = widget.assessment?.assessmentDteails?.duration!.toInt() ?? 1;

      startTimer();
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentCount--;
      setState(() {});
      if (seconds > 0) {
        seconds--;
        setState(() {});
      } else if (minutes > 0) {
        minutes--;
        seconds = 59;
        setState(() {});
      } else {
        timer.cancel();
        setState(() {}); // Stop the timer when it reaches 0
      }
    });
  }

  void _saveAnswer() {
    final assessmentProvider =
        Provider.of<AssessmentProvider>(context, listen: false);
    assessmentProvider.currentQuestion?.answer = answerController.text;

    setState(() {});
  }
}
