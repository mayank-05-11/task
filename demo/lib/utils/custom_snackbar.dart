import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class CustomSnackBar {
  static mySnackBar(BuildContext context, String message, {Color? color = AppColor.darkGrey, SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: AppColor.white,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: color,
        action: action,
      ),
    );
  }
}
