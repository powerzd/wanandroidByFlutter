import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/base/baseColors.dart';
import 'package:wanandroid/pages/home/HomePageProjectData.dart';
import 'package:wanandroid/pages/home/HomePageProjectData.dart' as prefix1;
import 'package:wanandroid/pages/home/HomePageResultData.dart';
import 'package:wanandroid/pages/home/HomePageResultData.dart' as prefix0;
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<prefix0.DataX> homePageResultDataList = [];
  List<prefix1.DataX> homePageProjectDataList = [];
  ScrollController _articleScrollController = new ScrollController();
  ScrollController _projectScrollController = new ScrollController();

  Future _future;
  int _articleCurrentPage = 1;
  int _projectCurrentPage = 1;
  bool isPerformingRequest = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _future = getHomePageData();
    _articleScrollController.addListener(() {
      if (_articleScrollController.position.pixels ==
          _articleScrollController.position.maxScrollExtent) {
        _articleCurrentPage++;
        getHomePageData();
      }
    });
    _projectScrollController.addListener(() {
      if (_projectScrollController.position.pixels ==
          _projectScrollController.position.maxScrollExtent) {
        _projectCurrentPage++;
        getHomePageData();
      }
    });
  }

// 加载更多 Widget
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
            padding: EdgeInsets.all(5.0),
            height: 35.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: baseColor,
            ),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Image.asset("assets/search.png"),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "点我开始搜索",
                    style: TextStyle(color: searchTextColor, fontSize: 16.0),
                  )
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "search");
              },
            )),
        bottom: TabBar(
          indicatorColor: Colors.grey,
          labelColor: Colors.grey,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "最新博文",
            ),
            Tab(
              text: "最新项目",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case ConnectionState.active:
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case ConnectionState.done:
                  {
                    return RefreshIndicator(
                      onRefresh: getHomePageData,
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        itemBuilder: (context, index) {
                          if (index == homePageResultDataList.length) {
                            return _buildProgressIndicator();
                          } else {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "detail", arguments: {
                                  "address": homePageResultDataList[index].link
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: baseColor))),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      homePageResultDataList[index].title,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(0, 3.0, 0, 3.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 8.0,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage:
                                                AssetImage("assets/logo.png"),
                                          ),
                                          Container(
                                            child: Text(
                                              homePageResultDataList[index]
                                                  .author,
                                            ),
                                            margin: EdgeInsets.fromLTRB(
                                                5.0, 0, 0, 0.0),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "分类: ",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(homePageResultDataList[index]
                                                .superChapterName),
                                            Text(" · ",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            Text(
                                              "时间: ",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(homePageResultDataList[index]
                                                .niceDate)
                                          ],
                                        ),
                                        PopupMenuButton<String>(
                                          onSelected: (String value) {
                                            Fluttertoast.showToast(msg: "暂未开放");
                                          },
                                          child: Image.asset(
                                            "assets/more.png",
                                            height: 20.0,
                                            width: 20.0,
                                          ),
                                          itemBuilder: (context) {
                                            return <PopupMenuItem<String>>[
                                              PopupMenuItem<String>(
                                                value: "收藏",
                                                child: Text("收藏"),
                                              )
                                            ];
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        itemCount: homePageResultDataList.length + 1,
                        controller: _articleScrollController,
                      ),
                    );
                  }
                case ConnectionState.none:
                  {
                    return Container();
                  }
              }
              return null;
            },
          ),
          FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case ConnectionState.active:
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case ConnectionState.done:
                  {
                    return RefreshIndicator(
                      onRefresh: getHomePageData,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) {
                          debugPrint(
                              "index  = $index,  length = ${homePageProjectDataList.length}");
                          if (index == homePageProjectDataList.length) {
                            return _buildProgressIndicator();
                          } else {
                            return Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: baseColor))),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "detail", arguments: {
                                      "address":
                                          homePageProjectDataList[index].link
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        homePageProjectDataList[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                                  child: Row(
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 8.0,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            AssetImage(
                                                                "assets/logo.png"),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          homePageProjectDataList[
                                                                  index]
                                                              .author,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                5.0, 0, 0, 0.0),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  homePageProjectDataList[index]
                                                      .desc,
                                                  style: TextStyle(
                                                      color: Colors.black87),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 10, 0, 0),
                                                child: Image.network(
                                                  homePageProjectDataList[index]
                                                      .envelopePic,
                                                  height: 90.0,
                                                  width: 160.0,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "分类: " +
                                                  homePageProjectDataList[index]
                                                      .superChapterName +
                                                  " · " +
                                                  "时间: " +
                                                  homePageProjectDataList[index]
                                                      .niceDate,
                                              style: TextStyle(
                                                  color: Colors.black38),
                                            ),
                                            PopupMenuButton(
                                              child: Image.asset(
                                                "assets/more.png",
                                                height: 20.0,
                                                width: 20.0,
                                              ),
                                              itemBuilder: (context) {
                                                return <PopupMenuItem<String>>[
                                                  PopupMenuItem<String>(
                                                    value:"收藏",
                                                    child: Text("收藏"),
                                                  ),
                                                  PopupMenuItem<String>(
                                                    value:"查看同类项目",
                                                    child: Text("查看同类项目"),
                                                  ),
                                                ];
                                              },
                                              onSelected: (value) {
                                                Fluttertoast.showToast(msg: "暂未开放");
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }
                        },
                        itemCount: homePageProjectDataList.length + 1,
                        controller: _projectScrollController,
                      ),
                    );
                  }
                case ConnectionState.none:
                  {
                    return Container();
                  }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Future getHomePageData() async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      HomePageResultData articleData;
      HomePageProjectData projectData;
      Dio dioHome = new Dio();
      var responseHomeResult = await Future.wait([
        dioHome.get(baseUrl + "article/list/${_articleCurrentPage - 1}/json"),
        dioHome.get(
            baseUrl + "article/listproject/${_projectCurrentPage - 1}/json")
      ]);
      var responseHomeResultJson = json.decode(responseHomeResult.toString());
      setState(() {
        if (homePageResultDataList != null && _articleCurrentPage == 1) {
          homePageResultDataList.clear();
        }

        if (homePageProjectDataList != null && _projectCurrentPage == 1) {
          homePageProjectDataList.clear();
        }
        articleData = HomePageResultData.fromJson(responseHomeResultJson[0]);
        for (int i = 0; i < articleData.data.datas.length; i++) {
          articleData.data.datas[i].title =
              articleData.data.datas[i].title.replaceAll("&amp", "");
          articleData.data.datas[i].title =
              articleData.data.datas[i].title.replaceAll("&rdquo", "");
          homePageResultDataList.add(articleData.data.datas[i]);
        }
        projectData = HomePageProjectData.fromJson(responseHomeResultJson[1]);
        for (int i = 0; i < projectData.data.datas.length; i++) {
          projectData.data.datas[i].title =
              projectData.data.datas[i].title.replaceAll("&amp", "");
          homePageProjectDataList.add(projectData.data.datas[i]);
        }
        isPerformingRequest = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _projectScrollController.dispose();
    _articleScrollController.dispose();
  }
}
