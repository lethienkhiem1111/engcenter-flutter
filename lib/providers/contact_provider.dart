
import 'package:dio/dio.dart';
import 'package:englcenterapp/config/api.dart';
import 'package:englcenterapp/models/contact_response.dart';
import 'package:englcenterapp/models/score_response.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class ContactProvider {
  
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000
  );
  final String sessionKey;
  List<ContactResponse> _contacts;

  List<ContactResponse> get contacts => _contacts;

  BehaviorSubject<ContactResponse> _subject = BehaviorSubject<ContactResponse>();

  BehaviorSubject<ContactResponse> get subject => _subject;

  ContactProvider(this.sessionKey, this._contacts) {
    _dio = Dio(options);
  }

  Future<ContactResponse> getContactOfClass(int idHocVien, int idLop) async{

    _subject.add(null);
    try {
         final response = await _dio.post('/get-so-lien-lac',
          data:{
            "sessionKey": sessionKey,
            "idHocVien": idHocVien,
            "idLop": idLop
            }, 
         options: Options(contentType:Headers.formUrlEncodedContentType )                
      );
      print('sessionId '+ sessionKey + ' ' + idHocVien.toString() + ' ' + idLop.toString() );
      
      ContactResponse contacts = await ContactResponse.fromJson(response.data);
     
      _subject.add(contacts);
    } catch (error) {
      _subject.add(ContactResponse.withError(error.toString()));
      print('error');
      print(error.toString());
    }
  }

  dispose() {
    _subject.close();
  }
}