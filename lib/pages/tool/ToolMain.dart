import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/tool/ToolBannerData.dart';
import 'package:wanandroid/pages/tool/ToolWebData.dart' as prefix0;

class ToolMain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ToolMainState();
  }

}

class ToolMainState extends State<ToolMain>{

  List<Data> _toolBannerList;
  List<prefix0.Data> _toolWebList;
  Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getToolsData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:FutureBuilder(
        builder: (context,snap){
          switch(snap.connectionState){

            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:{
              return Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Container(
                    height: 200.0,
                      child:Swiper(
                        itemCount: _toolBannerList.length,
                        itemBuilder: (context,index){
                          return Image.network(_toolBannerList[index].imagePath);
                        },
                        onTap: (index){
                          Navigator.pushNamed(
                              context, "detail", arguments: {
                            "address": _toolBannerList[index].url
                          });
                        },
                      )
                  ),
                  Flexible(
                    child:SingleChildScrollView(
                      child: Wrap(
                        spacing: 5.0,
                        children: _toolWebList.map<Widget>((data){
                          return GestureDetector(
                            child: Chip(
                              backgroundColor:getRandomColor(),
                              label: Text(data.name),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            onTap: (){
                              Navigator.pushNamed(context, "detail",arguments: {"address":data.link});
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              );
            }
          }
          return Container(
            height: 0,
            width: 0,
          );
        },
        future: _future,
      )
    );
  }

  Future getToolsData() async{
    Dio toolDio = new Dio();
    var toolResult = await Future.wait([
      toolDio.get(baseUrl + "banner/json"),
      toolDio.get(baseUrl + "friend/json"),
    ]);
    var toolResultJson = json.decode(toolResult.toString());
    ToolBannerData toolBannerData = ToolBannerData.fromJson(toolResultJson[0]);
    prefix0.ToolWebData toolWebData = prefix0.ToolWebData.fromJson(toolResultJson[1]);
    setState(() {
      _toolBannerList = toolBannerData.data;
      _toolWebList = toolWebData.data;
      debugPrint(_toolWebList.length.toString());
    });
  }

  getRandomColor() {
    return Color.fromARGB(
        255,
        Random.secure().nextInt(888),
        Random.secure().nextInt(888),
        Random.secure().nextInt(888));
  }
}