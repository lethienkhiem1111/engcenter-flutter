
import 'package:dio/dio.dart';
import 'package:englcenterapp/config/api.dart';
import 'package:englcenterapp/models/news_response.dart';
import 'package:englcenterapp/models/score_response.dart';
import 'package:rxdart/rxdart.dart';

class NewsProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: Api.baseUrl,
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
          data:{
            "trangThaiTinTuc": "1",
            "loaiTinTuc": "1",
            }, 
         options: Options(contentType:Headers.formUrlEncodedContentType )                
      );
      
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