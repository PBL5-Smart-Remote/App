// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:smart_home_fe/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_fe/models/user_model.dart';

class UserAPI {
  final String _loginAPI = '/users/login';
  final String _verifyTokenAPI = '/users/verifyToken';
  final String _registerAPI = '/users/register';
  final String _changePasswordAPI = '/users/changePassword';
  final String _getAllUsernameAPI = '/users/all-username';
  final String _getUserInfoAPI = '/users';

  final dio = Dio();

  Future<bool> login(String username, String password) async {
    try {
      String url = Uri.https(APIConfig.baseServerAppURL, _loginAPI).toString();
      final response = await dio.post(
        url,
        data: {
          'username': username,
          'password': password
        }
      );
      if (response.statusCode == 200) {
        final data = response.data;
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

      String url = Uri.https(APIConfig.baseServerAppURL, _verifyTokenAPI).toString();
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            "Authorization": token
          }
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
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
      String url = Uri.https(APIConfig.baseServerAppURL, _registerAPI).toString();

      final response = await dio.post(
        url,
        data : {
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

      String url = Uri.https(APIConfig.baseServerAppURL, _changePasswordAPI).toString();
      final response = await dio.patch(
        url,
        options: Options(
          headers: {
            "Authorization" : token
          },
        ),
        data: {
          "password": password
        }
      );
      print(response.data);
      return response.statusCode == 200;
    } catch (err) {
      print('[UserAPI][ChangePassword]: $err');
      return false;
    }
  }
  
  Future<List<String>> getAllUsername() async {
    try {
      String url = Uri.https(APIConfig.baseServerAppURL, _getAllUsernameAPI).toString();
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return data['usernames'].map((username) => username).toList();
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[UserAPI][GetAllUsername]: $err');
      return List.empty();
    }
  }

  Future<UserModel?> getUserInfo(String id) async {
    try {
      String url = Uri.https(APIConfig.baseServerAppURL, '$_getUserInfoAPI/$id').toString();
      final response = await dio.get(  
        url,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return UserModel(
          data['_id'],
          data['name'],
          data['email'],
          data['dob'],
          data['phoneNumber']
        );
      } else {
        return null;
      }
    } catch (err) {
      print('[UserAPI][GetUserInfo]: $err');
      return null;
    }
  }
}