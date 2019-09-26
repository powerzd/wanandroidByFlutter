import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/base/AppOptions.dart';

class WanAndroidApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

}

class _WanAndroidAppState extends State<WanAndroidApp>{
  AppOptions appOptions;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appOptions = AppOptions(themeMode: ThemeMode.system,targetPlatform: defaultTargetPlatform);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}