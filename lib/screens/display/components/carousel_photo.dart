import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notice/models/notices.dart';
import 'package:notice/widgets/build_dots.dart';
import 'package:flutter/material.dart';

class CarouselPhoto extends StatefulWidget {
  const CarouselPhoto(
      {super.key, required this.images, required this.function});

  final List<Files> images;
  final VoidCallback function;

  @override
  State<CarouselPhoto> createState() => _CarouselPhotoState();
}

class _CarouselPhotoState extends State<CarouselPhoto> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.images);
    return widget.images.isNotEmpty
        ? Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.red,
                width: 1.sw,
                // height: .5.sh,
                child: CarouselSlider.builder(
                  itemCount: widget.images.length,
                  itemBuilder: (BuildContext context, int i, int index) {
                    return CachedNetworkImage(
                      imageUrl: widget.images[i].fileLink,
                      placeholder: (context, url) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      fit: BoxFit.fitWidth,
                      width: 1.sw,
                    );
                  },
                  options: CarouselOptions(
                    initialPage: 0,
                    onPageChanged: (index, _) => setState(
                      () {
                        if (index == 0) {
                          widget.function();
                        }
                        this.index = index;
                      },
                    ),
                    viewportFraction: 1,
                    aspectRatio: 1.6,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                // heightFactor: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    color: Colors.grey.withOpacity(0.15),
                  ),
                  child: BuildDots(
                    index: index,
                    list: widget.images,
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
