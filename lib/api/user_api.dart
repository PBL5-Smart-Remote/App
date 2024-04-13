import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  final String _loginAPI = '/login';
  final String _verifyTokenAPI = '/verifyToken';
  final String _registerAPI = '/register';
  final String _changePasswordAPI = '/changePassword';

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.http(APIConfig.baseServerAppURL, _loginAPI),
        body: {
          'username': username,
          'password': password
        }
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('[UserAPI][Login]: $err');
      return false;
    }
  }

  Future<bool> verifyToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if(token == null) {
        return false;
      }
      final response = await http.post(
        Uri.http(APIConfig.baseServerAppURL, _verifyTokenAPI),
        headers: {
          "Authorization": token
        }
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await prefs.setString("token", data['token']);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('[UserAPI][VerifyToken]: $err');
      return false;
    }
  }

  Future<bool> register(
    String name, 
    String username, 
    String password, 
    String dateofbirth, 
    String email,
    String phonenumber) async {
    try {
      final response = await http.post(
        Uri.http(APIConfig.baseServerAppURL, _registerAPI),
        body : {
          "name": name, 
          "username": username,
          "password": password, 
          "email": email,
          "dateofbirth": dateofbirth,
          "phonenumber": phonenumber
        }
      );
      return response.statusCode == 200;
    } catch (err) {
      print('[UserAPI][Register]: $err');
      return false;
    }
  }
  
  Future<bool> changePassword(String password) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if(token == null) {
        return false;
      }
      final response = await http.patch(
        Uri.http(APIConfig.baseServerAppURL, _changePasswordAPI),
        headers: {
          "Authorization" : token
        },
        body: {
          "password": password
        }
      );
      return response.statusCode == 200;
    } catch (err) {
      print('[UserAPI][ChangePassword]: $err');
      return false;
    }
  }

}