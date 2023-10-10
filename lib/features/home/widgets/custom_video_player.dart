import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import '../../../general/utils/app_colors.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  const CustomVideoPlayer({super.key, this.videoUrl});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  String? videoUrl;
  late final PodPlayerController playerController;

  @override
  void initState() {
    videoUrl = widget.videoUrl;

    try {
      playerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(videoUrl!,
            videoPlayerOptions: VideoPlayerOptions()),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          videoQualityPriority: [1080, 720, 360],
        ),
      )..initialise();
    } catch (e) {
      log(e.toString());
    }

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      playerController.mute();
      playerController.pause();
    }
    playerController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PodVideoPlayer(
          controller: playerController,
          podProgressBarConfig: const PodProgressBarConfig(
            playingBarColor: AppColors.primaryColor,
            bufferedBarColor: AppColors.primaryColorLight,
            circleHandlerColor: AppColors.bgWhite,
            circleHandlerRadius: 6,
          )),
    );
  }
}
