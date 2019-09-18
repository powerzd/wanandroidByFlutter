import 'package:flutter/material.dart';
import 'package:wanandroid/pages/home/HomePage.dart';
import 'package:wanandroid/pages/settings/SettinsMain.dart';
import 'package:wanandroid/pages/system/SystemMain.dart';
import 'package:wanandroid/pages/weChatAccount/WeChatAccountMain.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin{
  int _currentIndex = 0;
  List pages = [HomePage(),WeChatAccountMain(),SystemMain(),HomePage(),SettingsMain()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text("公众号")),
          BottomNavigationBarItem(icon: Icon(Icons.storage), title: Text("体系")),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border), title: Text("收藏")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("设置")),
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
      ),
      body: pages[_currentIndex],
    );
  }
}
