import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const Color baseColor = Colors.red;

const double padding = 16.0;
final double radius = 8.r;

const basePadding =
    EdgeInsets.symmetric(horizontal: padding, vertical: padding * 1.5);

const tokenKey = "token";

const nepaliValue = "nepali";

// Secure Storage Login Credentials
const phoneKey = "phone";
const passwordKey = "password";

class UserConstants {
  static const apiKey = "b9ac8db19381c1b4c97e33a3540d1954";
}
