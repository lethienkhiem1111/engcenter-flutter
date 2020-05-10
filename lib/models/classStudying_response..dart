
import 'package:englcenterapp/models/class.dart';

class ClassStudyingResponse {
  final List<Class> classes;
  final String error;

  ClassStudyingResponse(this.classes, this.error);
  
  ClassStudyingResponse.fromJson(List<dynamic> dataList):
    classes =  dataList.map((e) => Class.fromJson(e)).toList(),
    error = '';
 
  ClassStudyingResponse.withError(String error): 
    classes = [],
    error = error;
    
}