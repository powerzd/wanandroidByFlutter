import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// ignore: must_be_immutable
class ShowDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowDetailState();
  }

}

class ShowDetailState extends State<ShowDetail> {

  String netAddress = "";
  StreamSubscription<WebViewStateChanged> onStateChanged;
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          switch (state.type) {
            case WebViewState.abortLoad:
              {
                break;
              }
            case WebViewState.finishLoad:
              {
                setState(() {
                  isLoading = false;
                });
                break;
              }
            case WebViewState.shouldStart:
              {
                setState(() {
                  isLoading = true;
                });
                break;
              }
            case WebViewState.startLoad:
              {
                setState(() {
                  isLoading = true;
                });
                break;
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute
        .of(context)
        .settings
        .arguments;
    if (data != null) {
      netAddress = data["address"];
    }
    // TODO: implement build
    return WebviewScaffold(
      withZoom: true,
      url: netAddress,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.grey,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title:isLoading ? SizedBox(height: 15.0,width: 15.0,child: CircularProgressIndicator(strokeWidth: 2.0,),) : Container(),
      ),
    );
  }

}