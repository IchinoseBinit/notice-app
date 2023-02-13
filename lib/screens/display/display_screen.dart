import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notice/models/notices.dart';
import 'package:notice/screens/display/components/body_content.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({
    super.key,
    required this.notices,
  });

  final List<Notices> notices;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TopHeader(
              //   height: height * .18,
              //   branch: branch,
              //   temp: temp,
              // ),
              // SizedBox(
              //   height: height * 0.015,
              // ),
              BodyContent(
                notice: notices,
                // height:
                //     height - ((height * .18) + (height * .03) + (height * .08)),
              ),
              // SizedBox(
              //   height: height * 0.015,
              // ),
              // BottomContent(
              //   height: height * .08,
              //   news: news,
              // ),
            ],
          );
        },
      ),
    );
  }
}
