


import 'package:dio/dio.dart';
import 'package:englcenterapp/models/hoso_response.dart';
import 'package:rxdart/rxdart.dart';

class HosoProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    // baseUrl: 'https://firstapp-14435.firebaseio.com/classes.json',
    baseUrl: 'http://mekosoft.vn:4088/api/jsonws/vn-mekosoft-giaviet-restapi-portlet.testapi/get-ho-so-of-user',
    connectTimeout: 5000,
    receiveTimeout: 5000
  );
  final String sessionKey;
  List<HosoResponse> _hosos;

  List<HosoResponse> get hosos => _hosos;
  BehaviorSubject<HosoResponse> _subject = BehaviorSubject<HosoResponse>();

  BehaviorSubject<HosoResponse> get subject => _subject;

  HosoProvider(this.sessionKey, this._hosos) {
    _dio = Dio(options);
  }

  Future<HosoResponse> getHosos() async{
    _hosos.add(null);
    try {
      final response = await _dio.post('',
          // headers: {
          //   "Accept": "application/json, text/javascript, /",
          //   "accept-language": "en-US,en;q=0.9",
          //   "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          //   "x-requested-with": "XMLHttpRequest"
          // },
          data:{"sessionKey": sessionKey}, 
         options: Options(contentType:Headers.formUrlEncodedContentType )
      );
        print(response);
      _subject.add(HosoResponse.fromJson(response.data));
    } catch (error, stacktrace) {
      print('errror');
      print(error);
      _subject.add(null);
    }
  }


  dispose() {
    _subject.close();
  }

}