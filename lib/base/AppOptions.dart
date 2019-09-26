import 'package:flutter/material.dart';

class AppOptions{
  //设置app的样式
  final ThemeMode themeMode;
  //选择平台
  final TargetPlatform targetPlatform;

  AppOptions({this.themeMode, this.targetPlatform});
}