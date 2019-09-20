import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/home/HomePageResultData.dart';


class CollectMain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CollectMainState();
  }

}

class CollectMainState extends State<CollectMain>{

  HomePageResultData homePageResultData;

  Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getCollect();
  }

  Widget _buildWaitingSimmer(){
    return ListView.builder(
      itemBuilder:(context,index){
        return ListTile(
          title:Shimmer.fromColors(child: Container(height: 15.0,color: Colors.white,), baseColor: Colors.grey[200], highlightColor: Colors.grey[100]),
          subtitle: Shimmer.fromColors(child: Container(height: 10.0,color: Colors.white,), baseColor: Colors.grey[200], highlightColor: Colors.grey[100])
        );
      },
      itemCount: 8,
    );
  }

  Widget _buildList(){
    return ListView.builder(
      itemBuilder:(context,index){
            return ListTile(
              onTap: (){
                Navigator.pushNamed(context, "detail",arguments: {"address":homePageResultData.data.datas[index].link});
              },
              title:Text(homePageResultData.data.datas[index].title),
              subtitle: Text(homePageResultData.data.datas[index].chapterName),
            );
      },
      itemCount: homePageResultData.data.datas.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("我的收藏",style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context,snp){
          switch(snp.connectionState){
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:{
              return _buildWaitingSimmer();
            }
            case ConnectionState.active:{
              break;
            }
            case ConnectionState.done:{
            return _buildList();
          }
          }
          return Container(height: 0,width: 0,);
        },
      ),
    );
  }

  Future getCollect() async{
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
    setState(() {
      homePageResultData = HomePageResultData.fromJson(collectResultJson);
    });
    debugPrint(collectResult.toString());
  }
}

