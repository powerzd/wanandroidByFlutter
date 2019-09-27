import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/system/SystemDetailData.dart';
import 'package:wanandroid/pages/system/SystemMainData.dart';

class SystemDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SystemDetailState();
  }
}

class _SystemDetailState extends State<SystemDetail>
    with TickerProviderStateMixin {

  String systemDetailTitle;
  List<Children> systemDetailTabs;
  TabController _tabController;
  List<SystemDetailData> _details = [];
  Future _detailFuture;
  List<Widget> widgetTabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getSystemDetail();
  }

  @override
  Widget build(BuildContext context) {

    dynamic data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      debugPrint("走一遍");
      systemDetailTitle = data["title"];
      systemDetailTabs = data["tabs"];
      systemDetailTabs.forEach((children) {
          _tabController = TabController(length: systemDetailTabs.length, vsync: this);
          print("_tabController.lenght = " + systemDetailTabs.length.toString());
      });
      widgetTabs = systemDetailTabs.map<Widget>((value) {
        print("widgetTabs.length = " + widgetTabs.length.toString());
        return Tab(
          text: value.name,
        );
      }).toList();
      _detailFuture = getSystemDetail();
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          systemDetailTitle,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: Colors.black,
          tabs: widgetTabs,
        ),
      ),
      body:FutureBuilder(
        future: _detailFuture,
        builder: (context,snap){
          switch(snap.connectionState){
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:{
              print("title = 1234");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:{
              return TabBarView(
                controller: _tabController,
                children: _details.map<Widget>((data){
                  return
                    ListView.separated(itemBuilder: (context,index){
                      print("title = " + data.data.datas[index].title);
                      return
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "detail",arguments: {"address":data.data.datas[index].link});
                            },
                            child:ListTile(
                              leading: GestureDetector(
                                onTap: (){

                                },
                                child: Icon(Icons.favorite_border),
                              ),
                              title: Text(data.data.datas[index].title),
                              subtitle: Text("作者: " + data.data.datas[index].author + " · 时间: " + data.data.datas[index].niceShareDate),
                            ),
                          );

                    },itemCount: data.data.datas.length,
                      separatorBuilder: (context,index){
                        return Divider();
                      },
                    );
                }
                ).toList(),
              );
            }
          }
          return Container(height: 0,width: 0,);
        },
      )
    );
  }
  
  Future getSystemDetail() async{
    _details.clear();
    List<Future> _dioList = [];
    Dio systemDetailDio = Dio();
    systemDetailTabs.forEach((tab){
      _dioList.add(systemDetailDio.get(baseUrl + "article/list/0/json?cid=${tab.id}"));
      print("params = " + baseUrl + "article/list/0/json?cid=${tab.id}");
    });

    var systemDetailResult = await Future.wait(_dioList);
    var systemDetailResultJson = json.decode(systemDetailResult.toString());
    for(int i = 0; i < systemDetailTabs.length; i++){
      _details.add(SystemDetailData.fromJson(systemDetailResultJson[i]));
    }
  }
}
