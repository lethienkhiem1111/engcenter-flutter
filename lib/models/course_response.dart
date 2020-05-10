
import 'package:englcenterapp/models/course.dart';

class CourseResponse {
  final List<Course> courses;
  final String error;

  CourseResponse(this.courses, this.error);
  
  CourseResponse.fromJson(Map<String, dynamic> json):
    courses = (json['data'] as List).map((e) => Course.fromJson(e)).toList(),
    error = '';
 
  CourseResponse.withError(String error): 
    courses = [],
    error = error;
    
}