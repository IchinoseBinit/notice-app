import 'dart:developer';

// import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:notice/utils/fetch_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/constants/storage_constants.dart';
import '/screens/login_screen.dart';
import '/utils/dio_client.dart';
import '/utils/navigate.dart';
import '/utils/preferences_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkToken(BuildContext context) async {
    PreferencesHelper.prefs = await SharedPreferences.getInstance();
    final val = PreferencesHelper.readKey(key: StorageConstants.tokenKey);
    log(val.toString(), name: "token");
    if (val != null && val.isNotEmpty) {
      DioClient();
      DioClient.token = val;
      // ignore: use_build_context_synchronously
      FetchContent().fetchAllContent(
        context,
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => navigateReplacement(
          context,
          LoginScreen(),
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    checkToken(
      context,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
