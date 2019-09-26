import 'package:flutter/material.dart';
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
  var _title;
  List<String> _tabs = [];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    _tabs.clear();
    dynamic data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      _title = data["title"];
      List<Children> tabData = data["tabs"];
      tabData.forEach((children) {
          _tabs.add(children.name);
          _tabController = TabController(length: _tabs.length, vsync: this);
          print("tab2 = " + _tabs.length.toString());
      });
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
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
          tabs: _tabs.map<Widget>((value) {
            return Tab(
              text: value,
            );
          }).toList(),

        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[Container(),Container(),Container()],
      ),
    );
  }
}
