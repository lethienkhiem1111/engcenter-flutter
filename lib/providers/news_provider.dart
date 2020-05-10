
import 'package:dio/dio.dart';
import 'package:englcenterapp/models/news_response.dart';
import 'package:englcenterapp/models/score_response.dart';
import 'package:rxdart/rxdart.dart';

class NewsProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    // baseUrl: 'https://firstapp-14435.firebaseio.com/classes.json',
    baseUrl: 'http://mekosoft.vn:4088/api/jsonws/vn-mekosoft-giaviet-restapi-portlet.testapi',
    connectTimeout: 5000,
    receiveTimeout: 5000
  );
  List<NewsResponse> _news;

  List<NewsResponse> get scores => _news;

  BehaviorSubject<NewsResponse> _subject = BehaviorSubject<NewsResponse>();

  BehaviorSubject<NewsResponse> get subject => _subject;

  NewsProvider() {
    _dio = Dio(options);
  }

  Future<NewsResponse> getAllNews() async{
    
    _subject.add(null);
    try {
         final response = await _dio.post('/get-tin-tuc',
          // headers: {
          //   "Accept": "application/json, text/javascript, /",
          //   "accept-language": "en-US,en;q=0.9",
          //   "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          //   "x-requested-with": "XMLHttpRequest"
          // },
          data:{
            "trangThaiTinTuc": "1",
            "loaiTinTuc": "1",
            }, 
         options: Options(contentType:Headers.formUrlEncodedContentType )                
      );
      // final jsonResponse = json.decode(response.data);
      // print('jsonReponse Type');
      // print('sessionId '+ sessionKey + ' ' + idHocVien.toString() + ' ' + idLop.toString() );
      // print(jsonResponse.runtimeType);
      // ScheduleResponse schedules = await ScheduleResponse.fromJson((jsonResponse['data'][0]['tuans']));
        print(response.data.toString());
        // print('isemptu');
        // print((response.data['data'][0]['tuans'] as List).isEmpty);
      // if((response.data['data'][0]['tuans'] as List).isEmpty) {
      //   _subject.add(ScheduleResponse.withError('Thời khóa biểu chưa cập nhập'));
      //   return ScheduleResponse.withError('Thời khóa biểu chưa cập nhập');
      // }
      print('No isEmpty');
      print(response.data['data']);
      
      NewsResponse scores = await NewsResponse.fromJson(response.data);
     
      _subject.add(scores);
    } catch (error) {
      _subject.add(NewsResponse.withError(error.toString()));
      print('error');
      print(error.toString());
    }
  }

  dispose() {
    _subject.close();
  }
}