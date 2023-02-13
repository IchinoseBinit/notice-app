import 'package:flutter/foundation.dart';

import '/constants/urls.dart';
import '/models/notices.dart';
import '/utils/dio_client.dart';
import '/utils/request_type.dart';

class NoticeApi {
  Future<List<Notices>> fetch() async {
    try {
      final resp = await DioClient().request(
        requestType: RequestType.getWithToken,
        url: ApiEndpoints.noticeUrl,
      );
      final list = <Notices>[];
      for (var notice in resp.data) {
        list.add(Notices.fromJson(notice));
      }
      return list;
    } catch (ex) {
      // debugPrint(ex.toString());
      return <Notices>[];
    }
  }
}
