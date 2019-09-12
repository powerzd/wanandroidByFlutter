import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/weChat/BannerResult.dart';
import 'package:wanandroid/pages/weChat/WechatChaptersData.dart';

class WeChatMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeChatMessageState();
  }
}

class WeChatMessageState extends State<WeChatMessage> {
  List<String> imaUrls = [];
  List<String> names = [];
  Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getBannerData();
    getBannerData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("公众号"),
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
                {
                  break;
                }
              case ConnectionState.done:
                {
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        height: 200.0,
                        color: Colors.blue,
                        child: Swiper(
                          itemCount: imaUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              imaUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0,200.0,0.0,0.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.favorite_border),
                              title: Text(names[index]),
                            );
                          },
                          itemCount: names.length,
                        ),
                      )
                    ],
                  );
                }
              case ConnectionState.waiting:
                {
                  break;
                }
              case ConnectionState.active:
                {
                  break;
                }
            }
            return Container(
              height: 0,
              width: 0,
            );
          },
        ),
      ),

    );
  }

  getBannerData() async {
    Dio weChatDio = new Dio();
    var weChatMessageResult = await Future.wait([
      weChatDio.get(baseUrl + "wxarticle/chapters/json"),
      weChatDio.get(baseUrl + "banner/json"),
    ]);
    var weChatMessageResultJson = json.decode(weChatMessageResult.toString());
    WeChatChaptersData weChatChaptersData = WeChatChaptersData.fromJson(weChatMessageResultJson[0]);
    BannerResultData bannerResultData =
        BannerResultData.fromJson(weChatMessageResultJson[1]);
    setState(() {
      for (int i = 0; i < bannerResultData.data.length; i++) {
        imaUrls.add(bannerResultData.data[i].imagePath);
      }

      for(int i = 0; i < weChatChaptersData.data.length; i++){
        names.add(weChatChaptersData.data[i].name);
      }

    });
  }
}
