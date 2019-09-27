import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/home/HomePageResultData.dart';
import 'package:wanandroid/pages/system/SystemMainData.dart';

class SystemMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SystemMainState();
  }
}

class SystemMainState extends State<SystemMain> with TickerProviderStateMixin {

  var _list = List.generate(20, (i)=>i);
  SystemMainData systemMainData;

  Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getSystem();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("体系",style: TextStyle(color: Colors.black),),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context,snap){
          switch(snap.connectionState){
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:{
              return _buildWaitingSimmer();
            }
            case ConnectionState.active:
              break;
            case ConnectionState.done:{
              return GridView.builder(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "systemDetail",arguments: {"title":systemMainData.data[index].name,"tabs":systemMainData.data[index].children});
                    },
                    child:Container(
                      child: Center(
                        child: Text(systemMainData.data[index].name),
                      ),
                      color: randomColor(),
                    )

                  );
                },
                itemCount: systemMainData.data.length,
              );
            }
          }
          return Container(
            height: 0,
            width: 0,
          );
        },
      ),

    );
  }

  Widget _buildWaitingSimmer(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context,index){
          return Shimmer.fromColors(child: Container(color: Colors.white,), baseColor: Colors.grey[200], highlightColor: Colors.grey[100]);
        },
      itemCount: 8,
    );
  }

  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(256)+0, Random().nextInt(256)+0, Random().nextInt(256)+0);
  }

  Future getSystem() async{
    Dio systemDio = Dio();
    var systemResult = await systemDio.get(baseUrl + "tree/json");
    var systemResultJson = json.decode(systemResult.toString());
    systemMainData = SystemMainData.fromJson(systemResultJson);
  }


}
