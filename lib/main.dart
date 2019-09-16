import 'package:flutter/material.dart';
import 'package:wanandroid/pages/home/MainPage.dart';
import 'package:wanandroid/pages/login/LoginMain.dart';
import 'package:wanandroid/pages/login/Register.dart';
import 'package:wanandroid/pages/login/LoginInfo.dart';
import 'package:wanandroid/pages/search/SearchMain.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wanandroid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      routes: {
        "login":(context)=>LoginMain(),
        "register":(context)=>Register(),
        "main":(context)=>MainPage(),
        "info":(context)=>LoginInfo(),
        "search":(context)=>SearchMain(),
      },
    );
  }
}