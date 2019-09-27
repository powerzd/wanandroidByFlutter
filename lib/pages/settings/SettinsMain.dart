import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/home/HomePageResultData.dart';
import 'package:wanandroid/pages/settings/SettingsRankData.dart';

class SettingsMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsMainState();
  }
}

class SettingsMainState extends State<SettingsMain> {
  Future _future;
  String _userName = "";
  List<String> cookie = [];
  SettingsRankData settingsRankData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getUserInfo();
    //getRankInfo();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2293fd),
        title: Container(
            padding: EdgeInsets.all(5.0),
            height: 35.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xff088fff),
            ),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Image.asset("assets/search.png", color: Color(0xff7abfff)),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "点我开始搜索",
                    style: TextStyle(color: Color(0xff7abfff), fontSize: 16.0),
                  )
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "search");
              },
            )),
      ),
      body: Stack(
        children: <Widget>[
          Container(height: 100.0, color: Colors.blue),
          Column(
            children: <Widget>[
              Container(
                  height: 120.0,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 0),
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      height: 100.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 35.0,
                                backgroundImage: AssetImage("assets/logo.png"),
                              )),
                          GestureDetector(
                            child: FutureBuilder(
                              future: _future,
                              builder: (context, snap) {
                                switch (snap.connectionState) {
                                  case ConnectionState.waiting:
                                    {
                                      return Text(
                                        _userName,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  case ConnectionState.active:
                                    {
                                      return Text(
                                        _userName,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  case ConnectionState.done:
                                    {
                                      return Text(
                                        _userName,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  case ConnectionState.none:
                                    {
                                      return Text(
                                        _userName,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                }
                                return Container(
                                  height: 0,
                                  width: 0,
                                );
                              },
                            ),
                            onTap: () {
                              if (_userName == "点击登录") {
                                Navigator.pushNamed(context, "login");
                              } else {
                                Navigator.pushNamed(context, "info");
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child:  Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/collect.png",
                            height: 40.0,
                            width: 40.0,
                          ),
                          Text("我的收藏")
                        ],
                      ),
                      onTap: (){
                        getCollect();

                      },
                    ),

                    GestureDetector(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/rank.png",
                            height: 40.0,
                            width: 40.0,
                          ),
                          Text("我的积分")
                        ],
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  height: 300.0,
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Material(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    child: FutureBuilder(
                                      future: getRankInfo(),
                                      builder: (context, s) {
                                        switch (s.connectionState) {
                                          case ConnectionState.none:
                                            // TODO: Handle this case.
                                            break;
                                          case ConnectionState.waiting:
                                            // TODO: Handle this case.
                                            break;
                                          case ConnectionState.active:
                                            // TODO: Handle this case.
                                            break;
                                          case ConnectionState.done:
                                            debugPrint("本站积分" +
                                                settingsRankData.data.coinCount
                                                    .toString());
                                            return Container(
                                              padding: EdgeInsets.all(10.0),
                                              child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Image.asset("assets/rank_2.png",height: 40.0,width: 40.0,),
                                                            Text("积分排行")
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Image.asset("assets/history.png",height: 40.0,width: 40.0,),
                                                            Text("积分历史")
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Image.asset("assets/total.png",height: 40.0,width: 40.0,),
                                                            Text("我的积分"),
                                                            Text("${settingsRankData.data.coinCount}")
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Image.asset("assets/my_rank.png",height: 40.0,width: 40.0,),
                                                            Text("我的排名"),
                                                            Text("${settingsRankData.data.rank}")
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );

                                        }
                                        return Container(
                                          height: 0,
                                          width: 0,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/settins.png",
                          height: 40.0,
                          width: 40.0,
                        ),
                        Text("其他设置")
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      cookie = sharedPreferences.getStringList("cookie");
      if (cookie == null) {
        _userName = "点击登录";
      } else {
        _userName = cookie[1].split(";")[0].split("=")[1];
      }
    });
    print(cookie[1].split(";")[0].split("=")[1]);
  }

  Future getRankInfo() async {
    Dio rankDio = new Dio();
    Map<String, dynamic> _headers = new Map();
    _headers["Cookie"] = cookie.toString();
    Options options = new Options();
    options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    options.headers = _headers;
    var rankResult =
        await rankDio.get(baseUrl + "lg/coin/userinfo/json", options: options);
    var rankResultJson = json.decode(rankResult.toString());
    setState(() {
      settingsRankData = SettingsRankData.fromJson(rankResultJson);
    });
    debugPrint("rankResult = " + rankResult.toString());
  }

  Future getCollect() async{
    HomePageResultData homePageResultData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dynamic cookie = sharedPreferences.getStringList("cookie");
    Dio collectDio = new Dio();
    Map<String, dynamic> _headers = new Map();
    _headers["Cookie"] = cookie.toString();
    Options options = new Options();
    options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    options.headers = _headers;
    var collectResult =
    await collectDio.get(baseUrl + "lg/collect/list/0/json", options: options);
    var collectResultJson = json.decode(collectResult.toString());
    homePageResultData = HomePageResultData.fromJson(collectResultJson);
    if(homePageResultData.errorCode == -1001){
      Fluttertoast.showToast(msg: homePageResultData.errorMsg);
    }else {
      Navigator.pushNamed(context, "collect");
    }
  }
}
