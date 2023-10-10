import 'package:athma_kalari_app/features/home/widgets/custom_video_player.dart';
import 'package:athma_kalari_app/general/assets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../general/services/custom_cached_network_image.dart';
import '../../../general/services/get_youtube_id_by_link.dart';
import '../../../general/utils/app_colors.dart';

class IntroductionVideoContainer extends StatefulWidget {
  final String videoUrl;
  final String? title;
  final String? subTitle;
  const IntroductionVideoContainer(
      {super.key, required this.videoUrl, this.title, this.subTitle});

  @override
  State<IntroductionVideoContainer> createState() =>
      _IntroductionVideoContainerState();
}

class _IntroductionVideoContainerState
    extends State<IntroductionVideoContainer> {
  bool showVideo = false;

  String? thumbnailUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showVideo
        ? CustomVideoPlayer(
            videoUrl: widget.videoUrl,
          )
        : Container(
            height: 200,
            width: double.infinity,
            color: AppColors.bgWhite,
            child: Stack(
              children: [
                CustomCachedNetworkImage(
                    height: 200,
                    width: double.infinity,
                    imageUrl:
                        'https://img.youtube.com/vi/${getYoutubeIdByLink(widget.videoUrl)}/0.jpg'),
                // Container(
                //   height: 200,
                //   width: double.infinity,
                //   color: Colors.black.withOpacity(0.4),
                // ),
                Positioned(
                  bottom: 10,
                  left: 8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.title ?? "",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.bgWhite,
                          )),
                      Text(widget.subTitle ?? "",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColors.bgWhite,
                          )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showVideo = true;
                    });
                  },
                  child: Center(
                    child: Image.asset(
                      AppIcons.videoPlayButton,
                      height: 50,
                      width: 50,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
