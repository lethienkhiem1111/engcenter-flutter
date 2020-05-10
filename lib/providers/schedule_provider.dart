
import 'package:dio/dio.dart';
import 'package:englcenterapp/models/schedule_response.dart';
import 'package:englcenterapp/models/schedules.dart';
import 'package:englcenterapp/models/schedules.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class ScheduleProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    // baseUrl: 'https://firstapp-14435.firebaseio.com/classes.json',
    baseUrl: 'http://mekosoft.vn:4088/api/jsonws/vn-mekosoft-giaviet-restapi-portlet.testapi',
    connectTimeout: 5000,
    receiveTimeout: 5000
  );
  final String sessionKey;
  List<ScheduleResponse> _schedules;

  List<ScheduleResponse> get schedules => _schedules;

  BehaviorSubject<ScheduleResponse> _subject = BehaviorSubject<ScheduleResponse>();

  BehaviorSubject<ScheduleResponse> get subject => _subject;

  ScheduleProvider(this.sessionKey, this._schedules) {
    _dio = Dio(options);
  }

  Future<ScheduleResponse> getAllSchedules(int idLop, int idHocVien) async{
    
    // print('Class Runtimetype');
    // print(idHocVien.runtimeType);
    // print(idLop.runtimeType);
    _subject.add(null);
    try {
         final response = await _dio.post('/get-thoi-khoa-bieu',
          // headers: {
          //   "Accept": "application/json, text/javascript, /",
          //   "accept-language": "en-US,en;q=0.9",
          //   "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          //   "x-requested-with": "XMLHttpRequest"
          // },
          data:{
            "sessionKey": sessionKey,
            "idHocVien": idHocVien,
            "idLop": idLop
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
      
      ScheduleResponse schedules = await ScheduleResponse.fromJson(response.data);
     
      _subject.add(schedules);
    } catch (error) {
      _subject.add(ScheduleResponse.withError(error.toString()));
      print('error');
      print(error.toString());
    }
  }

  dispose() {
    _subject.close();
  }
}