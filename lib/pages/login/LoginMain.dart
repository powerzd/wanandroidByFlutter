import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/login/RegisterResultData.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginMainState();
  }
}

class LoginMainState extends State<LoginMain> {
  String _userName = "";
  String _passward = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "账号密码登录",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.0),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelText: "账号"),
                    onChanged: (value) {
                      _userName = value;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelText: "密码"),
                    obscureText: true,
                    onChanged: (value) {
                      _passward = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      child: Text("登录"),
                      onPressed: () {
                        login();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child:Text(
                          "注册",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, "register");
                        },
                      ),

                      Text("忘记密码", style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ],
              )),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("第三方登录", style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/qq.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          onTap: (){
                            Fluttertoast.showToast(msg: "敬请期待",gravity: ToastGravity.CENTER);
                          },
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/weixin.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          onTap: (){
                            Fluttertoast.showToast(msg: "敬请期待",gravity: ToastGravity.CENTER);
                          },
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/weibo.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          onTap: (){
                            Fluttertoast.showToast(msg: "敬请期待",gravity: ToastGravity.CENTER);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  login() async{
    debugPrint(_passward + _userName);
    Dio loginDio = new Dio();
    FormData formData = FormData.from({
      "username":_userName,
      "password":_passward,
    });
    var loginResult = await loginDio.post(baseUrl + "user/login",data: formData);
    var loginResultJson = json.decode(loginResult.toString());
    RegisterResultData registerResultData = RegisterResultData.fromJson(loginResultJson);
    if(registerResultData.errorCode == 0){
      Fluttertoast.showToast(msg: "登录成功");
      setUser();
    }else {
      Fluttertoast.showToast(msg: registerResultData.errorMsg);
    }
  }

  setUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("userName",_userName);
    await Navigator.pushNamedAndRemoveUntil(context, "main",(router) => router == null);
  }
}
