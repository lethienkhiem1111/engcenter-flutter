import 'package:dio/dio.dart';
import 'package:englcenterapp/config/api.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _sessionId;
  DateTime _expiryDate = DateTime.now();
  // String _userId;
  // String _userName;
  String _gioiTinh;
  String _userName;
  String _hoTen;
  String _soDienThoai;
  String _email;
  String _ngaySinh;

  bool get isAuth {
    return _sessionId != null;
  }

  String get userName {
    if (_sessionId != null) {
      return _userName;
    } 
    return null; 
  }
  String get gioiTinh {
      if (_sessionId != null) {
      return _gioiTinh;
    } 
    return null; 
    
  }
  String get hoten {
      if (_sessionId != null) {
      return _hoTen;
    } 
    return null; 
 
  }
  String get phone {
    if (_sessionId != null) {
      return _soDienThoai;
    } 
    return null; 
  }
  String get email {
    if (_sessionId != null) {
      return _email;
    } 
    return null; 
  }
  String get ngaysinh {
    if (_sessionId != null) {
      return _ngaySinh;
    } 
    return null; 
  }

  String get sessionId {
    if (_sessionId != null) {
      return _sessionId;
    } 
    return null;
  }

  Future<void> _authenticate(String username, String password, String urlSegment) async {
    final url = Api.baseUrl + '/login';
    print(username + password);
    try {
      final response = await http.post(
        url,
          headers: {
            "Accept": "application/json, text/javascript, /",
            "accept-language": "en-US,en;q=0.9",
            "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
            "x-requested-with": "XMLHttpRequest"
          },
          body: {
            "username": username,
            "password": password
          },
      );
         
      final responseData = json.decode(response.body);
      print(response.body);
      if ((responseData['sessionKey']).toString().isEmpty) {
        throw HttpException(responseData['Some wrong']);
      }
      _sessionId = responseData['sessionKey'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse('3600'),
        ),
      );
      getUserInfo(_sessionId);
      print(_sessionId);
      // _autoLogout();
      
      notifyListeners();

      
    } catch (error) {
      throw error;
    }
  }

  Future<void> getUserInfo(String sessionKey) async {
    final url = Api.baseUrl + '/get-user';
    try {
      final response = await http.post(
        url,
          headers: {
            "Accept": "application/json, text/javascript, /",
            "accept-language": "en-US,en;q=0.9",
            "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
            "x-requested-with": "XMLHttpRequest"
          },
          body: {
            "sessionKey": sessionKey,
          },
      );
         
      final responseData = json.decode(response.body);
      print(response.body);
      if ((responseData['username']).toString().isEmpty) {
        throw HttpException(responseData['Some wrong']);
      }
      _userName = responseData['username'];
      _gioiTinh = responseData['gioiTinh'];
      _hoTen = responseData['hoTen'];
      _soDienThoai = responseData['soDienThoai'];
      _email = responseData['email'];
      _ngaySinh = responseData['ngaySinh'];
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'sessionId': _sessionId,
        'gioiTinh': responseData['gioiTinh'],
        'userName': responseData['username'],
        'hoTen': responseData['hoTen'],
        'soDienThoai': responseData['soDienThoai'],
        'email': responseData['email'],
        'ngaySinh': responseData['ngaySinh'], 
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('userData', userData);
      print('token' + _sessionId);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

 
  Future<void> signup(String username, String password) async{
    return _authenticate(username, password, 'signUp');
  }
  Future<void> login(String username, String password) async{
    return _authenticate(username, password, 'login');
  }

  Future<bool> tryLogin() async {
    
    final prefs = await SharedPreferences.getInstance();
    
    if(!prefs.containsKey('userData')){
      return false;
    }
    final extractedUserData =json.decode(prefs.getString('userData')) as Map<String, Object>;
    final experyData = DateTime.parse(extractedUserData['expiryDate']);
    if(experyData.isBefore(DateTime.now())) {
      return false;
    }
    if(extractedUserData['userName'] == null) {
      prefs.remove('userData');
      return false;
    }
    print(extractedUserData);
    _sessionId = extractedUserData['sessionId'];
    _gioiTinh = extractedUserData['gioiTinh'];
    _userName = extractedUserData['userName'];
    _hoTen = extractedUserData['hoTen'];
    _soDienThoai = extractedUserData['soDienThoai'];
    _email = extractedUserData['email'];
    _ngaySinh = extractedUserData['ngaySinh'];
    _expiryDate = DateTime.parse(extractedUserData['expiryDate']);

   
    notifyListeners();
    return true;  
   
  }

  void logout() async{
    _sessionId = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    print(timeToExpire);
    Future.delayed(Duration(seconds: timeToExpire), () {
      logout();
    });
  }
}

// await fetch(APIConst.APIURL + "/login", {
//                 credentials: "include",
//                 headers: {
//                   accept: "application/json, text/javascript, /",
//                   "accept-language": "en-US,en;q=0.9",
//                   "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
//                   "x-requested-with": "XMLHttpRequest"
//                 },
//                 auth: {
//                   user: "test@liferay.com",
//                   pass: "test"
//                 },
//                 method: "POST",
//                 body: 
//                 "username=" + username 
//                 + "&password=" + password
//               })
//                 .then(res => res.json())
//                 .then(response => {
//                   console.log("data.sessionKey=" + response.sessionKey);
//                   if (response.sessionKey !== ""&&response.sessionKey!==undefined) {
//                     data = response;
//                     AsyncStorage.setItem('userGroup', response.userGroup);
//                     AsyncStorage.setItem('sessionKey', response.sessionKey);
//                   }
//                 })
//                 .catch(e => {
//                    console.log(e);
//                 });
//         }