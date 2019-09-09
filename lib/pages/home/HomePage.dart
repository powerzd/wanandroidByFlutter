import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/home/HomePageProjectData.dart';
import 'package:wanandroid/pages/home/HomePageResultData.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin  {
  TabController _tabController;
  HomePageResultData articleData;
  HomePageProjectData projectData;
  Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =  TabController(length: 2, vsync: this);
    _future = getHomePageData();
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
//          Text("1234"),
//          Text("5678"),
          FutureBuilder(
            future: _future,
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                case ConnectionState.active:{
                  return Center(
                    child: CircularProgressIndicator(

                    ),
                  );
                }
                case ConnectionState.done:{
                  return ListView.builder(itemBuilder: (context,index){
                    return ListTile(
                      leading: Icon(Icons.favorite_border,color: Colors.red),
                      title: Text(articleData.data.datas[index].title),
                      subtitle: Text(articleData.data.datas[index].superChapterName + " " +
                          articleData.data.datas[index].niceDate + " " +
                          articleData.data.datas[index].author),
                    );
                  },
                  itemCount: articleData.data.datas.length,
                  );
                }
                case ConnectionState.none:{
                  return Container(
                    child: Text("1234"),
                  );
                }
              }
              return null;
            },
          ),
          FutureBuilder(
            future: _future,
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                case ConnectionState.active:{
                  return Center(
                    child: CircularProgressIndicator(

                    ),
                  );
                }
                case ConnectionState.done:{
                  return ListView.builder(itemBuilder: (context,index){
                    return ListTile(
                      leading: Icon(Icons.favorite_border,color: Colors.red),
                      title: Text(projectData.data.datas[index].title),
                      
                    );
                  },
                    itemCount: projectData.data.datas.length,
                  );
                }
                case ConnectionState.none:{
                  return Container(
                    child: Text("1234"),
                  );
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
    Dio dioHome = new Dio();
    var responseHomeResult = await Future.wait([
      dioHome.get(baseUrl + "article/list/0/json"),
      dioHome.get(baseUrl + "article/listproject/0/json")
    ]);
    var responseHomeResultJson = json.decode(responseHomeResult.toString());
    debugPrint(responseHomeResultJson.toString());
    articleData = HomePageResultData.fromJson(responseHomeResultJson[0]);
    projectData = HomePageProjectData.fromJson(responseHomeResultJson[1]);
  }
}
