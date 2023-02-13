import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notice/utils/dio_client.dart';
import 'package:notice/utils/request_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:notice/models/notices.dart';

class NoticeContainer extends StatefulWidget {
  const NoticeContainer(
      {super.key, required this.notices, required this.callback});

  final List<Files> notices;
  final VoidCallback callback;

  @override
  State<NoticeContainer> createState() => _NoticeContainerState();
}

class _NoticeContainerState extends State<NoticeContainer> {
  late PdfViewerController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = PdfViewerController()
      ..addListener(() {
        controller.zoomLevel = 0;
        Future.delayed(const Duration(seconds: 10), () {
          if (controller.pageNumber < controller.pageCount) {
            controller.nextPage();
          } else {
            if (index < widget.notices.length - 1) {
              index++;
              setState(() {});
            } else {
              widget.callback();
            }
          }
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  downloadFile() async {
    try {
      final path = (await getTemporaryDirectory()).path;
      final response = await DioClient().request(
        requestType: RequestType.get,
        url: widget.notices[index].fileLink,
        responseType: ResponseType.bytes,
      );
      final data = response.data;
      return data;
    } catch (ex) {
      print(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 4,
      ),
      height: 1.sh,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: .1.sh,
            child: Text("Notice ${index + 1} of ${widget.notices.length}"),
          ),
          FutureBuilder(
              future: downloadFile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final data = snapshot.data;

                  return SizedBox(
                    height: .78.sh,
                    child: SfPdfViewer.memory(
                      data as Uint8List,
                      controller: controller,
                      onDocumentLoadFailed: (details) {},
                      onDocumentLoaded: (d) {
                        Future.delayed(
                          const Duration(seconds: 10),
                          () => controller.nextPage(),
                        );
                      },
                      initialZoomLevel: 0,
                    ),
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
