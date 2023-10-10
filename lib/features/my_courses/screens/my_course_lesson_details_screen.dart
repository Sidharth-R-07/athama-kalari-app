import 'dart:developer';

import 'package:athma_kalari_app/features/courses/models/course_model.dart';
import 'package:athma_kalari_app/features/courses/provider/course_provider.dart';
import 'package:athma_kalari_app/features/courses/screens/course_details_screen.dart';
import 'package:athma_kalari_app/features/home/widgets/custom_video_player.dart';
import 'package:athma_kalari_app/features/home/widgets/introduction_video_container.dart';
import 'package:athma_kalari_app/features/my_courses/providers/my_courses_provider.dart';
import 'package:athma_kalari_app/features/my_courses/widgets/my_course_lesson_frame.dart';
import 'package:athma_kalari_app/general/services/custom_toast.dart';
import 'package:athma_kalari_app/general/services/pdf_services.dart';

import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../general/utils/app_colors.dart';

class MyLessonDetailsScreen extends StatefulWidget {
  final LessonModel? lesson;

  final List<LessonModel>? allLessons;
  final int? index;
  const MyLessonDetailsScreen(
      {super.key, this.lesson, this.index, this.allLessons});

  @override
  State<MyLessonDetailsScreen> createState() => _MyLessonDetailsScreenState();
}

class _MyLessonDetailsScreenState extends State<MyLessonDetailsScreen> {
  double? _progress;

  @override
  Widget build(BuildContext context) {
    String formattedNumber = (widget.index! + 1).toString().padLeft(2, '0');

    final relatedLessons = widget.allLessons!
        .where((element) => element.index != widget.lesson!.index)
        .toList();

    log("Related lessons ${relatedLessons[0].title}");
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWhite,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: Text(
          widget.lesson!.title!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:
                IntroductionVideoContainer(videoUrl: widget.lesson!.videoLink!),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: RichText(
              text: TextSpan(
                text: ' $formattedNumber ',
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: widget.lesson!.title!,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                widget.lesson!.description ?? "No description available",
                trimLines: 10,
                colorClickableText: AppColors.primaryColor,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                moreStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
                lessStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: widget.lesson?.pdfUrl != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      height: 50,
                      minWidth: double.infinity,
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _progress != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_progress%',
                                  style: const TextStyle(
                                    color: AppColors.primaryColorLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Downloading...',
                                  style: TextStyle(
                                    color: AppColors.primaryColorLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconlyLight.paper,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'View Study Material',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                      onPressed: () async {
                        if (_progress != null) {
                          return CustomToast.successToast(
                              message: "Already downloading");
                        }
                        FileDownloader.downloadFile(
                          url: widget.lesson!.pdfUrl!,
                          onProgress: (count, total) {
                            setState(() {
                              _progress = total;
                            });
                          },
                          onDownloadCompleted: (path) {
                            setState(() {
                              _progress = null;
                            });
                            CustomToast.successToast(
                              message: "Download Completed :$path",
                            );
                          },
                        );
                      },
                    ),
                  )
                : null,
          ),

          // Related Lessons

          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Related Videos",
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),

          SliverList.separated(
            itemCount: relatedLessons.length,
            itemBuilder: (context, index) => MyCourseLessonFrame(
                lesson: relatedLessons[index],
                index: index,
                allLessons: widget.allLessons!),
            separatorBuilder: (context, index) => const SizedBox(height: 6),
          )
        ],
      ),
    );
  }
}
