
import 'package:dio/dio.dart';
import 'package:englcenterapp/models/course_response.dart';
import 'package:rxdart/rxdart.dart';

class CourseProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: 'http://mekosoft.vn:4088/api/jsonws/vn-mekosoft-giaviet-restapi-portlet.testapi/get-khoa-chieu-sinh/trang-thai-ky-thi-id/4',
    connectTimeout: 5000,
    receiveTimeout: 5000
  );
  final String authToken;
  List<CourseResponse> _courses;

  List<CourseResponse> get courses => _courses;
  BehaviorSubject<CourseResponse> _subject = BehaviorSubject<CourseResponse>();

  BehaviorSubject<CourseResponse> get subject => _subject;

  CourseProvider(this.authToken, this._courses) {
    _dio = Dio(options);
  }

  Future<CourseResponse> getAllCourses() async{
    _courses.add(null);
    try {
      final response = await _dio.get('?auth=$authToken');
      print((response.data).runtimeType);
      print('response');
      _subject.add(CourseResponse.fromJson(response.data));
    } catch (error, stacktrace) {
      print('errror');
      print(error);
      _subject.add(null);
    }
    print(_subject.value);
  }
  dispose() {
    _subject.close();
  }

}