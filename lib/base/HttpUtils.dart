import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wanandroid/base/WABaseResp.dart';



class HttpUtils {
  static final HttpUtils _instance = HttpUtils._init();
  static Dio _dio;

  BaseOptions _options = BaseOptions(
    contentType: ContentType.json,
    connectTimeout:30000,
    receiveTimeout: 30000,
  );

  HttpUtils._init() {
    _dio = Dio(_options);
  }

  void setCookie(cookie){
    Map<String,dynamic> _headers = Map();
    _headers["Cookie"] = cookie;
    _dio.options.headers.addAll(_headers);
  }

  Future<WABaseResp<T>> request<T>(String method,String path,{data,Options options,CancelToken cancelToken}) async{
    Response response =await _dio.request(path,data: data,options: setOptions(method,options),cancelToken: cancelToken);
    String _status;
    int _errCode;
    T _data;
    String _errMsg;
    if(response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created){
      try{
        if(response is Map){
          _status = response.data["status"];
          _errCode = response.data["errorCode"];
          _errMsg = response.data["errorMsg"];
          _data = response.data["data"];
        }else {
          Map<String,dynamic> _mapData = Map();
          _mapData = decodeData(response);
          _status = _mapData["status"];
          _errCode = _mapData["errorCode"];
          _errMsg = _mapData["errorMsg"];
          _data = _mapData["data"];
        }
        return WABaseResp(_status,_errCode,_errMsg,_data);
      }catch (e){
        return Future.error(new DioError(
          response: response,
          message: "data parse exception",
          type: DioErrorType.RESPONSE
        ));
      }

    }
    return Future.error(DioError(
      response: response,
      message: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  Options setOptions(method,options){
    if(options == null){
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Map<String,dynamic> decodeData(Response response){
    if(response != null && response.data != null && response.data.toString().length > 0){
      return json.decode(response.data.toString());
    }else {
      return new Map();
    }
  }

}
