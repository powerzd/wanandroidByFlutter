import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanandroid/base/api.dart';
import 'package:wanandroid/base/baseColors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/pages/search/HotSearchResultData.dart';
import 'package:wanandroid/pages/search/SearchResultData.dart';

class SearchMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchMainState();
  }
}

class SearchMainState extends State<SearchMain> {
  List<String> _maybeList = ["Android", "Java", "Kotlin"];
  Future _future;
  Future _futureResult;
  String _hintTextValue = "Android";
  List<DataX> _searchResultList = [];
  FocusNode _commentFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getHotSearchData();
    _futureResult = getSearchData("Android");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            decoration: BoxDecoration(
                color: baseColor, borderRadius: BorderRadius.circular(8.0)),
            child: TextField(
              focusNode: _commentFocus,
              onSubmitted: (value){
                _futureResult = getSearchData(value);
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: _hintTextValue),
              textInputAction: TextInputAction.search,
            ),
          ),
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
              size: 36.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "你可能在找",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: FutureBuilder(
              future: _future,
              builder: (context, snp) {
                switch (snp.connectionState) {
                  case ConnectionState.none:
                    {
                      break;
                    }
                  case ConnectionState.active:
                    {
                      break;
                    }
                  case ConnectionState.waiting:
                    {
                      break;
                    }
                  case ConnectionState.done:
                    {
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 2.0,
                        children: _maybeList.map<Widget>((s) {
                          return GestureDetector(
                            child: Chip(
                              label: Text('$s'),
                            ),
                            onTap: (){
                              _commentFocus.unfocus();
                              _futureResult =  getSearchData('$s');
                              setState(() {
                                _hintTextValue = '$s';
                              });
                            },
                          );
                        }).toList(),
                      );
                    }
                }
                return Container(
                  height: 0.0,
                  width: 0.0,
                );
              },
            ),
          ),
          FutureBuilder(
            future: _futureResult,
            builder: (context, snp) {
              switch (snp.connectionState) {
                case ConnectionState.none:
                  {
                    break;
                  }
                case ConnectionState.active:
                  {
                    break;
                  }
                case ConnectionState.waiting:
                  {
                   return Center(
                     child: Container(
                       child: CircularProgressIndicator(),
                       margin: EdgeInsets.fromLTRB(0, 100.0, 0, 0),
                     ),
                   );
                  }
                case ConnectionState.done:
                  {
                    return Flexible(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(width: 1, color: baseColor))
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, "detail",arguments: {"address":_searchResultList[index].link});
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 10.0,),
                                        Text(_searchResultList[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                        Text("作者: " + _searchResultList[index].author),
                                        SizedBox(height: 10.0,),
                                      ],
                                    ),
                                  )

                                );
                            },
                            itemCount: _searchResultList.length,
                      ),
                    ));
                  }
              }
              return Container(
                height: 0.0,
                width: 0.0,
              );
            },
          )
        ],
      ),
    );
  }

  Future getHotSearchData() async {
    _maybeList = [];
    Dio hotSearchDio = new Dio();
    var hotSearchResult = await hotSearchDio.get(baseUrl + "/hotkey/json");
    var hotSearchResultJson = json.decode(hotSearchResult.toString());
    HotSearchResultData hotSearchResultData =
        HotSearchResultData.fromJson(hotSearchResultJson);
    setState(() {
      for (int i = 0; i < hotSearchResultData.data.length; i++) {
        _maybeList.add(hotSearchResultData.data[i].name);
      }
    });
  }

  Future getSearchData(value) async {
    _searchResultList = [];
    Dio searchDio = new Dio();
    FormData data = FormData.from({"k": value});
    var searchResult =
        await searchDio.post(baseUrl + "article/query/0/json", data: data);
    debugPrint(searchResult.toString());
    var searchResultJson = json.decode(searchResult.toString());
    SearchResultData searchResultData =
        SearchResultData.fromJson(searchResultJson);
    setState(() {
      for (int i = 0; i < searchResultData.data.datas.length; i++) {
        searchResultData.data.datas[i].title = searchResultData.data.datas[i].title.replaceAll("<em class='highlight'>","");
        searchResultData.data.datas[i].title = searchResultData.data.datas[i].title.replaceAll("</em>", "");
        searchResultData.data.datas[i].title = searchResultData.data.datas[i].title.replaceAll("&amp", "");
        _searchResultList.add(searchResultData.data.datas[i]);
      }
    });
  }
}
