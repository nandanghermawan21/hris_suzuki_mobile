import 'package:flutter/material.dart';

class MenuModel {
  String? title;
  IconData? icon;
  Color? iconBackgroundColor;
  Color? backgroundColor;
  Color? iconColor;
  Function? onTap;

  MenuModel({
    this.title,
    this.icon,
    this.iconBackgroundColor,
    this.backgroundColor = Colors.white,
    this.iconColor,
    this.onTap,
  });
}