import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notice/models/notices.dart';

import 'package:flutter/cupertino.dart';
import 'package:notice/screens/display/components/image_video_container.dart';

class BodyContent extends StatelessWidget {
  const BodyContent({
    super.key,
    // required this.height,
    required this.notice,
  });

  // final double height;
  final List<Notices> notice;
  // final Images images;
  // final List<Staff> staff;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;
    return Container(
      height: 1.sh,
      width: width + 32,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: MediaQuery.of(context).viewPadding.top,
      ),
      child: ImageNoticeContainer(
        notices: notice,
      ),
    );
  }
}
