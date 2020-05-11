
import 'package:dio/dio.dart';
import 'package:englcenterapp/config/api.dart';
import 'package:englcenterapp/models/schedule_response.dart';
import 'package:englcenterapp/models/schedules.dart';
import 'package:englcenterapp/models/schedules.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class ScheduleProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: Api.baseUrl,
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
    
    _subject.add(null);
    try {
         final response = await _dio.post('/get-thoi-khoa-bieu',
          data:{
            "sessionKey": sessionKey,
            "idHocVien": idHocVien,
            "idLop": idLop
            }, 
         options: Options(contentType:Headers.formUrlEncodedContentType )                
      );
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