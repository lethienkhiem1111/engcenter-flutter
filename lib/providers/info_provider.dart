import 'package:dio/dio.dart';
import 'package:englcenterapp/helper/cache_interceptor.dart';
import 'package:englcenterapp/models/info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduction {

  BaseOptions options = BaseOptions(
    baseUrl: 'https://firstapp-14435.firebaseio.com/introduction',
    receiveTimeout: 5000, 
    connectTimeout: 5000
    );  
  Dio _dio;
  final String _authToken;
  String _info;

  final BehaviorSubject<InfoResponse> _subject = BehaviorSubject<InfoResponse>();
  
  Introduction(this._authToken, this._info){
    _dio = Dio(options);
     _dio.interceptors
    ..add(CacheInterceptor())
    ..add(LogInterceptor(requestHeader: false, responseHeader: false));
    // _dio.interceptors.add(LoggingInterceptor());
  }

  String get info => _info;
  BehaviorSubject<InfoResponse> get subject => _subject;

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      // DioError dioError = error as DioError;
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }


  Future<InfoResponse> getInfo(String segment) async {
    _subject.sink.add(null);
    final String _endpoint = "https://firstapp-14435.firebaseio.com/introduction/$segment.json";
    // print('qwcw' + _authToken);
    try {

      Response response = await _dio.get('/$segment.json', options: Options(extra: {'segment': segment}));
      //   print(response);
      // if(response.statusCode != 200) {
      //   return InfoResponse.withError(response.data.error);
      // }
      
      _subject.sink.add(InfoResponse.fromJson(response.data.toString()));
      print(response.data.toString());
      return InfoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('cache errr');
      print(_handleError(error));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey(segment)) {
        print(prefs.get(segment));
        _subject.sink.add(InfoResponse.fromJson(prefs.get(segment)));
        return InfoResponse.fromJson(prefs.get(segment));
      }
      _subject.sink.add(InfoResponse.withError(_handleError(error)));
      return InfoResponse.withError(_handleError(error));
      
    }
  }



  dispose() {
    _subject.close();
  }

  
}