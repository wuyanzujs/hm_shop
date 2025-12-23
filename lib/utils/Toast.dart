import 'package:flutter/material.dart';

class HMToast {
  static bool _isShow = false;
  static void show(BuildContext context, String? message) {
    if (HMToast._isShow) return;
    HMToast._isShow = true;
    Future.delayed(Duration(seconds: 3), () {
      HMToast._isShow = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        content: Text(message ?? "加载成功", textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
