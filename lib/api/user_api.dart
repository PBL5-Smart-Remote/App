import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  final String _loginAPI = '/users/login';
  final String _verifyTokenAPI = '/users/verifyToken';
  final String _registerAPI = '/users/register';
  final String _changePasswordAPI = '/users/changePassword';
  final String _getAllUsername = '/users/all-username';

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.http(APIConfig.baseServerAppURL, _loginAPI),
        body: {
          'username': username,
          'password': password
        }
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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
        print('No token stored');
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
        print(data);
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
    String email,
    String dateofbirth, 
    String phonenumber) async {
    try {
      final response = await http.post(
        Uri.http(APIConfig.baseServerAppURL, _registerAPI),
        body : {
          "name": name, 
          "username": username,
          "password": password, 
          "email": email,
          "dateOfBirth": dateofbirth,
          "phoneNumber": phonenumber
        }
      );
      return response.statusCode == 201;
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
      print(jsonDecode(response.body));
      return response.statusCode == 200;
    } catch (err) {
      print('[UserAPI][ChangePassword]: $err');
      return false;
    }
  }
  
  Future<List<String>> getAllUsername() async {
    try {
      final response = await http.get(
        Uri.http(APIConfig.baseServerAppURL, _getAllUsername),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['usernames'].map((username) => username).toList();
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[UserAPI][GetAllUsername]: $err');
      return List.empty();
    }
  }

}