import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/weChatAccount/WeChatDetailData.dart'
    as prefix0;
import 'package:wanandroid/pages/weChatAccount/weChatAccountData.dart';

class WeChatAccountMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeChatAccountMainState();
  }
}

class WeChatAccountMainState extends State<WeChatAccountMain>
    with SingleTickerProviderStateMixin {
  int weChatId = 408;
  int titleIndex = 0;
  Future _future;
  static const _panelHeaderHeight = 48.0;
  List<Data> _lists;
  List<prefix0.DataX> _detailList;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getBaseData(weChatId);
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose(); //回收动画
    super.dispose();
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Widget _buildStacks(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    final ThemeData themeData = Theme.of(context);
    return new Container(
      color: themeData.primaryColor,
      child: new Stack(
        children: <Widget>[
          new Center(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    setState(() {
                      weChatId = _lists[index].id;
                      titleIndex = index;
                    });
                    _future = getBaseData(weChatId);
                    _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
                  },
                  title: Text(_lists[index].name),
                );
              },
              itemCount: _lists.length,
            ),
          ),
          PositionedTransition(
            rect: animation,
            child: Material(
              borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0),
              ),
              elevation: 12.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: _panelHeaderHeight,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                      child: Text(
                        _lists[titleIndex].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "detail",
                                  arguments: {
                                    "address": _detailList[index].link
                                  });
                            },
                            title: Text(_detailList[index].title),
                            subtitle:
                                Text("时间: " + _detailList[index].niceDate),
                          );
                        },
                        itemCount: _detailList.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height - _panelHeaderHeight;
    final double bottom = -_panelHeaderHeight;
    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("微信公众号"),
          leading: IconButton(
            onPressed: () {
              _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller.view,
            ),
          ),
        ),
        body: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.waiting:{
                return Center(

                  child: Material(  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(16.0),
                    topRight: const Radius.circular(16.0),
                  ),child: CircularProgressIndicator(),),
                );
              }
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                {
                  return LayoutBuilder(
                    builder: _buildStacks,
                  );
                }
            }
            return new Container(width: 0.0, height: 0.0);
          },
        ));
  }

  Future getBaseData(id) async {
    Dio baseDio = new Dio();
    var baseResult = await Future.wait([
      baseDio.get(baseUrl + "wxarticle/chapters/json"),
      baseDio.get(baseUrl + "wxarticle/list/$id/1/json"),
    ]);
    var baseResultJson = json.decode(baseResult.toString());
    WeChatAccountData weChatAccountData =
        WeChatAccountData.fromJson(baseResultJson[0]);
    prefix0.WeChatDetailData weChatDetailData =
        prefix0.WeChatDetailData.fromJson(baseResultJson[1]);
    setState(() {
      _lists = weChatAccountData.data;
      _detailList = weChatDetailData.data.datas;
    });
  }
}

