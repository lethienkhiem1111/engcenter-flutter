

import 'package:englcenterapp/models/hoso.dart';

class HosoResponse {
  final List<Hoso> hosos;
  final String result;

  HosoResponse(this.hosos, this.result);
  
  HosoResponse.fromJson(Map<String, dynamic> json):
    hosos = (json['data'] as List).map((e) => Hoso.fromJson(e)).toList(),
    result = json['result'];
 
  HosoResponse.withError(String error): 
    hosos = [],
    result = "Some wrong";
    
}