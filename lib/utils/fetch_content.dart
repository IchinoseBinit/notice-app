import 'package:flutter/material.dart';
import '/utils/error_handler.dart';

import '/api/notice_api.dart';
import '/screens/display/display_screen.dart';
import '/screens/login_screen.dart';
import '/utils/navigate.dart';

class FetchContent {
  fetchAllContent(
    BuildContext context, {
    bool isFromLogin = false,
  }) async {
    try {
      final notice = await NoticeApi().fetch();
      var temp = 0;
      navigateReplacement(
        context,
        DisplayScreen(
          notices: notice,
        ),
      );
    } catch (ex) {
      if (isFromLogin) {
        return ErrorHandler().errorHandler(context, ex);
      }
      navigateAndRemoveAll(context, LoginScreen());
    }
  }
}
