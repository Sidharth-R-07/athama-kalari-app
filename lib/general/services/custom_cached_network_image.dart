import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'custom_image_shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.height = 80,
    this.width = 80,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
          child: SizedBox(
              height: height! > 80 ? 60 : height,
              width: width! > 80 ? 60 : width,
              child: const CustomImageShimmer())),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
