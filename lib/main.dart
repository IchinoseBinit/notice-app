import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/screens/login_screen.dart';
import '/screens/splash_screen.dart';

import '/constants/constant.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // PreferencesHelper.prefs = await SharedPreferences.getInstance();
  // ConnectivityApi().monitorConnection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        // systemNavigationBarContrastEnforced: true,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Display App',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: child!,
            ),
          ),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: LoginScreen(),
          home: const SplashScreen(),
        );
      },
    );
  }
}
