
import 'package:dio/dio.dart';
import 'package:englcenterapp/config/api.dart';
import 'package:englcenterapp/models/classStudying_response..dart';
import 'package:englcenterapp/models/class_response.dart';
import 'package:englcenterapp/models/http_exception.dart';

import 'package:rxdart/rxdart.dart';

class ClassProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000
  );
  final String sessionKey;
  List<ClassResponse> _classes;
  List<ClassStudyingResponse> _classesStudying;


  List<ClassResponse> get classes => _classes;
  List<ClassStudyingResponse> get classesStudying => _classesStudying;

  BehaviorSubject<ClassResponse> _subject = BehaviorSubject<ClassResponse>();
  BehaviorSubject<ClassStudyingResponse> _subjectStudying = BehaviorSubject<ClassStudyingResponse>();

  BehaviorSubject<ClassResponse> get subject => _subject;
  BehaviorSubject<ClassStudyingResponse> get subjectStudying => _subjectStudying;

  ClassProvider(this.sessionKey, this._classes) {
    _dio = Dio(options);
  }

  Future<ClassResponse> getAllClassesByCourseId(int idKhoa) async{
    _subject.add(null);
    try {
      final response = await _dio.get('/get-lop/id-khoa/$idKhoa');
      print(response.data.toString());
      print('response');
      _subject.add(ClassResponse.fromJson(response.data));
    } catch (error, stacktrace) {
      print('errror');
      print(error);
      _subject.add(null);
    }
    print(_subject.value);
  }

  Future<ClassStudyingResponse> getClassStudying(int idHocVien) async{
    _subjectStudying.add(null);
    try {
      final response = await _dio.post('/get-lop-of-ho-so',
          data:{
            "sessionKey": sessionKey,
            "idHocVien": idHocVien
            }, 
         options: Options(contentType:Headers.formUrlEncodedContentType )                 
      );
   
       if (response.data['result'] != 'success') {
        throw HttpException('Some wrong');
      }
      _subjectStudying.add(ClassStudyingResponse.fromJson(response.data['data'][0]['lop']));
    } catch (error, stacktrace) {
      print('errror');
      print(error);
      _subjectStudying.add(null);
    }
  }

  dispose() {
    _subjectStudying.close();
  }

}
