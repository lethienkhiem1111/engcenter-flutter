
import 'package:englcenterapp/models/class.dart';

class ClassResponse {
  final List<Class> classes;
  final String error;

  ClassResponse(this.classes, this.error);
  
  ClassResponse.fromJson(Map<String, dynamic> json):
    classes = (json['data'] as List).map((e) => Class.fromJson(e)).toList(),
    error = '';
 
  ClassResponse.withError(String error): 
    classes = [],
    error = error;
    
}