// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:display_app/constants/constant.dart';
// import 'package:display_app/screens/splash_screen.dart';
// import 'package:flutter/material.dart';

// class ConnectivityApi {
//   final Connectivity _connectivity = Connectivity();

//   var isOnline = true;
//   var callApi = false;

//   Future<void> checkIsOnline() async {
//     try {
//       final response = await InternetAddress.lookup('www.google.com');
//       if (response.isNotEmpty) {
//         isOnline = true;
//       } else {
//         isOnline = false;
//       }
//     } on SocketException {
//       isOnline = false;
//     }
//   }

//   ConnectivityApi() {
//     checkIsOnline();
//   }

//   Future monitorConnection() async {
//     _connectivity.onConnectivityChanged.listen((event) async {
//       if (event == ConnectivityResult.mobile ||
//           event == ConnectivityResult.wifi ||
//           event == ConnectivityResult.bluetooth) {
//         await checkIsOnline();
//         if (isOnline && callApi) {
//           callApi = false;
//           navigatorKey.currentState?.pushAndRemoveUntil(
//             MaterialPageRoute(builder: (_) => const SplashScreen()),
//             (_) => false,
//           );
//         } else if (!isOnline) {
//           callApi = true;
//         }
//       } else {
//         callApi = true;
//       }
//     });
//   }
// }
