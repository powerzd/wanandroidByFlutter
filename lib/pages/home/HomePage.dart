import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/home/HomePageProjectData.dart';
import 'package:wanandroid/pages/home/HomePageProjectData.dart' as prefix1;
import 'package:wanandroid/pages/home/HomePageResultData.dart';
import 'package:wanandroid/pages/home/HomePageResultData.dart' as prefix0;

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
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        bottom: TabBar(
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
                        itemBuilder: (context, index) {
                          if(index == homePageResultDataList.length){
                            return _buildProgressIndicator();
                          }else {
                            return ListTile(
                              leading:
                              Icon(Icons.favorite_border, color: Colors.red),
                              title: Text(homePageResultDataList[index].title),
                              subtitle: Text("分类: " +
                                  homePageResultDataList[index].superChapterName +
                                  " " +
                                  "时间: " +
                                  homePageResultDataList[index].niceDate +
                                  " " +
                                  "作者: " +
                                  homePageResultDataList[index].author),
                            );
                          }

                        },
                        itemCount: homePageResultDataList.length + 1  ,
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
                        itemBuilder: (context, index) {
                          if(index == homePageProjectDataList.length){
                            return _buildProgressIndicator();
                          }else {
                            return ListTile(
                              leading:
                              Icon(Icons.favorite_border, color: Colors.red),
                              title: Text(homePageProjectDataList[index].title),
                            );
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
    if(!isPerformingRequest){
      setState(() {
        isPerformingRequest = true;
      });
      if (homePageResultDataList != null && _articleCurrentPage == 1) {
        homePageResultDataList.clear();
      }

      if (homePageProjectDataList != null && _projectCurrentPage == 1) {
        homePageProjectDataList.clear();
      }

      HomePageResultData articleData;
      HomePageProjectData projectData;
      Dio dioHome = new Dio();
      var responseHomeResult = await Future.wait([
        dioHome.get(baseUrl + "article/list/${_articleCurrentPage - 1}/json"),
        dioHome
            .get(baseUrl + "article/listproject/${_projectCurrentPage - 1}/json")
      ]);
      var responseHomeResultJson = json.decode(responseHomeResult.toString());
      setState(() {
        articleData = HomePageResultData.fromJson(responseHomeResultJson[0]);
        for (int i = 0; i < articleData.data.datas.length; i++) {
          homePageResultDataList.add(articleData.data.datas[i]);
        }
        projectData = HomePageProjectData.fromJson(responseHomeResultJson[1]);
        for (int i = 0; i < projectData.data.datas.length; i++) {
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
