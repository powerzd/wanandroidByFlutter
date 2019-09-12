import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/pages/login/RegisterResultData.dart';

class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }

}

class RegisterState extends State<Register>{

  String _userName = "";
  String _passward = "";
  String _repeatPassward = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("账号注册"),
      ),
      body:Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Text(
              "普通账号注册",
              style:
              TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                labelText: "账户名称",
              ),
              onChanged: (value){
                setState(() {
                  _userName = value;
                });
              },
            ),
            SizedBox(height: 20.0,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                labelText: "密码",
              ),
              onChanged:(value){
                setState(() {
                  _passward = value;
                });
              },
              obscureText: true,
            ),
            SizedBox(height: 20.0,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                labelText: "重复密码",
              ),
              onChanged: (value){
                _repeatPassward = value;
              },
              obscureText: true,
            ),
            SizedBox(height: 20.0,),
            Container(
              height: 50.0,
                child:RaisedButton(
                  child: Text("注册"),
                  onPressed: () {
                    register();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  color: Colors.blue,
                ),
            ),
          ],
        ),
      )

    );
  }

  register() async{
    Dio registerDio = new Dio();
    FormData formData = FormData.from({
      "username":_userName,
      "password":_passward,
      "repassword":_repeatPassward,
    });
    var registerResult = await registerDio.post(baseUrl + "user/register",data: formData);
    var registerResultJson = json.decode(registerResult.toString());
    RegisterResultData registerResultData = RegisterResultData.fromJson(registerResultJson);
    if(registerResultData.errorCode == 0){
      Fluttertoast.showToast(msg: "注册成功");
      Navigator.pushNamed(context, "main");
    }else {
      Fluttertoast.showToast(msg: registerResultData.errorMsg);
    }
  }
}