
import 'package:dio/dio.dart';
import 'package:englcenterapp/models/classStudying_response..dart';
import 'package:englcenterapp/models/class_response.dart';
import 'package:englcenterapp/models/http_exception.dart';

import 'package:rxdart/rxdart.dart';

class ClassProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    // baseUrl: 'https://firstapp-14435.firebaseio.com/classes.json',
    baseUrl: 'http://mekosoft.vn:4088/api/jsonws/vn-mekosoft-giaviet-restapi-portlet.testapi',
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
          // headers: {
          //   "Accept": "application/json, text/javascript, /",
          //   "accept-language": "en-US,en;q=0.9",
          //   "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          //   "x-requested-with": "XMLHttpRequest"
          // },
          data:{
            "sessionKey": sessionKey,
            "idHocVien": idHocVien
            }, 
         options: Options(contentType:Headers.formUrlEncodedContentType )                 
      );
      // dio.post("/info", data:{"id":5}, 
      //    options: Options(contentType:Headers.formUrlEncodedContentType ));
   
       if (response.data['result'] != 'success') {
        throw HttpException('Some wrong');
      }
      // print(response.data['data']);
      // print(response.data['data'][0]['lop']);
      // print(response.data['data'][0]['lop'].runtimeType);
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
