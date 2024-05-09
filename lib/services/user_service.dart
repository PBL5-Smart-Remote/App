import 'package:smart_home_fe/api/user_api.dart';
import 'package:smart_home_fe/models/user_model.dart';

class UserService {
  final userAPI = UserAPI();

  Future<bool> login(String username, String password) async {
    try {
      return await userAPI.login(username, password);
    } catch (err) {
      print('[UserService][Login]: $err');
      return false;
    }
  }

  Future<bool> verifyToken() async {
    try {
      return await userAPI.verifyToken();
    } catch (err) {
      print('[UserService][VerifyToken]: $err');
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
      return await userAPI.register(name, username, password, email, dateofbirth, phonenumber);
    } catch (err) {
      print('[UserService][Register]: $err');
      return false;
    }
  }

  Future<bool> changePassword(String password) async {
    try {
      return await userAPI.changePassword(password);
    } catch (err) {
      print('[UserService][VerifyToken]: $err');
      return false;
    }
  }

  Future<List<String>> getAllUsername() async {
    try {
      return await userAPI.getAllUsername();
    } catch (err) {
      print('[UserService][GetAllUsername] : $err' );
      return List.empty();
    }
  }

  Future<UserModel?> getUserInfo(String id) async {
    try {
      return await userAPI.getUserInfo(id);
    } catch (err) {
      print('[UserService][GetUserInfo] : $err' );
      return null;
    }
  }
}