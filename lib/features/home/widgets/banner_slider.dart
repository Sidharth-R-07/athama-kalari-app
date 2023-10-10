import 'package:athma_kalari_app/features/home/models/banner_model.dart';
import 'package:athma_kalari_app/general/services/custom_cached_network_image.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../general/services/custom_image_shimmer.dart';
import '../providers/banner_provider.dart';

class BannerImageSlider extends StatefulWidget {
  const BannerImageSlider({super.key});

  @override
  State<BannerImageSlider> createState() => _BannerImageSliderState();
}

class _BannerImageSliderState extends State<BannerImageSlider> {
  int activeIndex = 0;

  _getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BannerProvider>(context, listen: false).fetchAllBanner();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bannerListner = Provider.of<BannerProvider>(context);
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: bannerListner.isLoading == true
          ? const Center(
              child: SizedBox(
                height: 70,
                width: 70,
                child: CustomImageShimmer(),
              ),
            )
          : Center(
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      if (bannerListner.bannerList.isEmpty) {
                        return const Center(
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: CustomImageShimmer(),
                          ),
                        );
                      }
                      return _buildBannerImage(
                          bannerListner.bannerList[index], index);
                    },
                    itemCount: bannerListner.bannerList.length ?? 0,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: bannerListner.bannerList.length,
                          effect: const WormEffect(
                            dotColor: AppColors.bgGrey,
                            activeDotColor: AppColors.primaryColor,
                            dotHeight: 6,
                            dotWidth: 10,
                          )),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildBannerImage(BannerModel banner, int index) {
    return Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bgWhite,
        ),
        child: CustomCachedNetworkImage(imageUrl: banner.image!));
  }
}
