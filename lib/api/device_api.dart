import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceAPI {
  final String _changeStatusAPI = '/esps';

  Future<bool> changeStatus(DeviceControlModel model) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.post(
        Uri.https(APIConfig.baseServerAppURL, '$_changeStatusAPI/${model.idESP}'),
        headers: {
          // "Authorization": token!,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "devices": [
            {
              "id": model.idDevice,
              "status": (model.status == 1 ? "on" : "off")
            }
          ]
        })
      );
      return response.statusCode ~/ 100 == 2;
    } catch (err) {
      print('[DeviceAPI][ChangeStatus]: $err');
      return false;
    }
  }
}