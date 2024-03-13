import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/esp_model.dart';

class ESPAPI {
  final String _getESPsAPI = '/esps/all';
  

  Future<List<ESPModel>> getESPs() async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.get(
        Uri.http(APIConfig.baseServerAppURL, _getESPsAPI),
        // headers: {
        //   "Authorization": token!
        // },
      );
      print(Uri.http(APIConfig.baseServerAppURL, _getESPsAPI).toString());
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return List<ESPModel>.from(data.map((esp) => ESPModel(
          esp['_id'],
          esp['_idESP'],
          esp['isConnected'],
          List<DeviceModel>.from(esp['devices'].map((device) => DeviceModel(
            esp['_idESP'],
            device['_id'],
            device['pin'],
            device['name'],
            device['type'],
            device['isConnected'],
            device['status']
          ))
        ))));
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[ESPAPI][GetESPs]: $err');
      return List.empty();
    }
  }
}