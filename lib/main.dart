import 'package:flutter/material.dart';
import 'package:wanandroid/pages/collect/CollectMain.dart';
import 'package:wanandroid/pages/detail/ShowDetail.dart';
import 'package:wanandroid/pages/home/MainPage.dart';
import 'package:wanandroid/pages/login/LoginMain.dart';
import 'package:wanandroid/pages/login/Register.dart';
import 'package:wanandroid/pages/login/LoginInfo.dart';
import 'package:wanandroid/pages/search/SearchMain.dart';
import 'package:wanandroid/pages/system/SystemDetail.dart';
import 'package:wanandroid/pages/tool/ToolMain.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wanandroid',
      //设置主题
      theme: ThemeData(

      ),
      home: MainPage(),
      routes: {
        "login":(context)=>LoginMain(),
        "register":(context)=>Register(),
        "main":(context)=>MainPage(),
        "info":(context)=>LoginInfo(),
        "search":(context)=>SearchMain(),
        "detail":(context)=>ShowDetail(),
        "tool":(context)=>ToolMain(),
        "collect":(context)=>CollectMain(),
        "systemDetail":(context)=>SystemDetail(),
      },
    );
  }
}