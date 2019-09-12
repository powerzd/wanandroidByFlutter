import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsMainState();
  }
}

class SettingsMainState extends State<SettingsMain> {
  Future _future;
  String _userName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getUserInfo();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Stack(
        children: <Widget>[
          Container(height: 100.0, color: Colors.blue),
          Container(
              height: 120.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 0),
              child: Card(
                color: Colors.white,
                child: Container(
                  height: 100.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 35.0,
                            backgroundImage: AssetImage("assets/logo.png"),
                          )),
                      GestureDetector(
                        child: FutureBuilder(
                          future: _future,
                          builder: (context, snap) {
                            switch (snap.connectionState) {
                              case ConnectionState.waiting:
                                {
                                  return Text(
                                    "点击登录",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              case ConnectionState.active:
                                {
                                  return Text(
                                    "点击登录",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              case ConnectionState.done:
                                {
                                  return Text(
                                    _userName,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              case ConnectionState.none:
                                {
                                  return Text(
                                    "点击登录",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                            }
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                        onTap: () {
                          if (_userName == "点击登录") {
                            Navigator.pushNamed(context, "login");
                          } else {
                            Navigator.pushNamed(context, "info");
                          }
                        },
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future getUserInfo() async {
    debugPrint("个人信息");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _userName = sharedPreferences.getString("userName");
      if(_userName == null){
        _userName = "点击登录";
      }
      debugPrint("userName" + _userName);
    });
  }
}
