// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/connection_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionAPI {
  final String _setupAPI = "/setup";

  final dio = Dio();

  Future<bool> setupESP(ConnectionModel connection) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('iduser');
      String url = Uri.https(APIConfig.baseEspURL, _setupAPI).toString();
      final response = await dio.post(
        url,
        // options: Options(
        //   headers: {
        //     "Authorization": token!
        //   },
        // ),
        data: {
          // "iduser": connection.idUser,
          "ssid": connection.ssid,
          "password": connection.password
        }
      );
      return response.statusCode == 200;
    } catch (err) {
      print('[ConnectionAPI][SetupESP]: $err');
      return false;
    }
  }
}