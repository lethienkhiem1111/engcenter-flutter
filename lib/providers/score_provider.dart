
import 'package:dio/dio.dart';
import 'package:englcenterapp/config/api.dart';
import 'package:englcenterapp/models/score_response.dart';
import 'package:rxdart/rxdart.dart';

class ScoreProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000
  );
  final String sessionKey;
  List<ScoreResponse> _scores;

  List<ScoreResponse> get scores => _scores;

  BehaviorSubject<ScoreResponse> _subject = BehaviorSubject<ScoreResponse>();

  BehaviorSubject<ScoreResponse> get subject => _subject;

  ScoreProvider(this.sessionKey, this._scores) {
    _dio = Dio(options);
  }

  Future<ScoreResponse> getScoreOfClass(int idLop, int idHocVien) async{
    _subject.add(null);
    try {
         final response = await _dio.post('/get-diem',
          data:{
            "sessionKey": sessionKey,
            "idHocVien": idHocVien,
            "idLop": idLop
            }, 
         options: Options(contentType:Headers.formUrlEncodedContentType )                
      );
      
      ScoreResponse scores = await ScoreResponse.fromJson(response.data);
     
      _subject.add(scores);
    } catch (error) {
      _subject.add(ScoreResponse.withError(error.toString()));
      print('error');
      print(error.toString());
    }
  }

  dispose() {
    _subject.close();
  }
}