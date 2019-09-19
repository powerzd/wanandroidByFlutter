import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/base/baseColors.dart';
import 'package:wanandroid/pages/system/SystemTabData.dart' as prefix1;
import 'package:wanandroid/pages/weChatAccount/WeChatDetailData.dart'
    as prefix0;
import 'package:wanandroid/pages/weChatAccount/weChatAccountData.dart';

class SystemMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SystemMainState();
  }
}

class SystemMainState extends State<SystemMain> with TickerProviderStateMixin {
  int weChatId = 408;
  Future _future;
  int tabLength = 4;
  AnimationController _controller;
  List<prefix1.Data> _tabs;
  List<prefix1.Data> _allTabs;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getSystemTab();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: -1.0,
      vsync: this,
    );
    _tabController = TabController(
      length: _tabs == null ? 4 : _tabs.length,
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
      child: new Stack(
        children: <Widget>[
          new Center(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("11234"),
                );
              },
              itemCount: 3,
            ),
          ),
          PositionedTransition(
            rect: animation,
            child: Material(
              elevation: 12.0,
              child: ListView(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40.0,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "已有体系",
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                  ),
                  Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: _tabs.map<Widget>((data) {
                        return GestureDetector(
                          child:Chip(
                            backgroundColor: Color(0xffE0E0E0),
                            label: Text(data.name),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              _tabs.remove(data);
                              _allTabs.add(data);
                              _tabController.dispose();
                              _tabController = TabController(
                                length: _tabs.length,
                                vsync: this,
                              );
                            });
                          },
                        );
                      }).toList()),
                  Container(
                    height: 40.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "体系推荐 ",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          "点击添加体系",
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: _allTabs.map<Widget>((data) {
                        return GestureDetector(
                          child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.transparent,
                            label: Text(data.name),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                )
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              _tabs.add(data);
                              _allTabs.remove(data);
                              _tabController.dispose();
                              _tabController = TabController(
                                length: _tabs.length,
                                vsync: this,
                              );
                            });
                          },
                        );
                      }).toList()),
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
    final double top = height;
    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(0.0, top, 0.0, 0.0),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
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
          leading: IconButton(
            color: Colors.grey,
            onPressed: () {
              _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller.view,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs.map<Widget>((data) {
              return Tab(
                child: Text(
                  data.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            controller: _tabController,
          ),
        ),
        body: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.waiting:
                {
                  return Center(
                    child: Material(),
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

  Future getSystemTab() async {
    Dio tabDio = Dio();
    var tabResult = await tabDio.get(baseUrl + "tree/json");
    var tabResultJson = json.decode(tabResult.toString());
    prefix1.SystemTabData systemTabData =
        prefix1.SystemTabData.fromJson(tabResultJson);
    setState(() {
      _tabs = systemTabData.data.sublist(0, 4);
      _allTabs = systemTabData.data.sublist(5,systemTabData.data.length);
      tabLength = _tabs.length;
      debugPrint(_tabs.length.toString());
    });
  }
}
