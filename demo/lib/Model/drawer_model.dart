import 'package:flutter/cupertino.dart';

class DrawerModel {
  late final IconData icon;
  late final String title;
  late final String? key;
  void Function()? onTap;
  DrawerModel({
    required this.onTap,
    required this.title,
    required this.icon,
    this.key,
  });
}
