
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/interface/callback.dart';

class DioManager{

  Dio dio;

  static DioManager _instance;

  static DioManager get instance => _instance;

  factory DioManager() => _getInstance();

  static DioManager _getInstance(){
    if(_instance == null){
      _instance = new DioManager._internal();
    }
    return _instance;
  }

  DioManager._internal(){
    dio = new Dio();
  }

  void request(String url, RequestCallback callback) async {
    var response = await dio.get(url);
    try{
      if (response.statusCode == HttpStatus.ok) {
        var data = response.data.toString();
        callback.requestSuccessful(data);
      }else{
        callback.requestFailed("Http status ${response.statusCode}");
      }
    }catch(exception){

    }

  }

}