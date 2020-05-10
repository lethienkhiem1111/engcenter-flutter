
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:englcenterapp/models/info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheInterceptor extends Interceptor {

  var segment;
  CacheInterceptor();

  var _cache = Map<Uri, Response>();

  @override
  Future onRequest(RequestOptions options) async {
     if (options.extra.containsKey("segment")) {
       segment = options.extra['segment'];
     }
    Response response = _cache[options.uri];
    if (options.extra["refresh"] == true) {
      print("${options.uri}: force refresh, ignore cache! \n");
      return options;
    } else if (response != null) {
      print("cache hit: ${options.uri} \n");
      return response;
    }
  }

  @override
  Future onResponse(Response response) async {
    _cache[response.request.uri] = response;
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(segment)){
      prefs.remove(segment);
    }
    print(response.data);
    String info = response.data.toString();
    
    prefs.setString(segment.toString(), info);

  }

  @override
  Future onError(DioError e) async {
    print('onError: $e');
  }
}