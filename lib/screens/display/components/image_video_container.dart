import 'package:flutter/material.dart';
import 'package:notice/models/notices.dart';
import 'package:notice/screens/display/components/notice_content.dart';

import '/screens/display/components/carousel_photo.dart';

class ImageNoticeContainer extends StatefulWidget {
  const ImageNoticeContainer({super.key, required this.notices});

  final List<Notices> notices;

  @override
  State<ImageNoticeContainer> createState() => _ImageNoticeContainerState();
}

class _ImageNoticeContainerState extends State<ImageNoticeContainer> {
  late bool showImage;

  late List<Files> images;
  late List<Files> files;

  int index = 0;

  toggleImageVideoView() {
    if (index < widget.notices.length - 1) {
      index++;
    } else {
      index = 0;
    }
    images = widget.notices[index].files
        .where((e) => e.fileType.toLowerCase() == "image".toLowerCase())
        .toList();
    files = widget.notices[index].files
        .where((e) => e.fileType.toLowerCase() == "pdf".toLowerCase())
        .toList();

    showImage = images.isNotEmpty;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    images = widget.notices[index].files
        .where((e) => e.fileType.toLowerCase() == "image".toLowerCase())
        .toList();
    files = widget.notices[index].files
        .where((e) => e.fileType.toLowerCase() == "pdf".toLowerCase())
        .toList();

    showImage = images.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return widget.notices.isEmpty
        ? const Center(
            child: Text("No images or notices to show"),
          )
        : showImage
            ? CarouselPhoto(
                // images: widget.notices,
                images: images,
                function: toggleImageVideoView,
              )
            : NoticeContainer(
                notices: files,
                callback: toggleImageVideoView,
              );
  }
}
