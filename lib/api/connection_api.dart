import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/connection_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionAPI {
  static const String _setupAPI = "/setup";

  static Future<bool> setupESP(ConnectionModel connection) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.post(
        Uri.http(APIConfig.baseEspURL, _setupAPI),
        // headers: {
        //   "Authorization": token!
        // },
        body: {
          "ssid": connection.ssid,
          "password": connection.password
        }
      );
      return response.statusCode == 200;
    } catch (err) {
      print(err);
      return false;
    }
  }
}