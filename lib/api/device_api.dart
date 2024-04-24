import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_update_model.dart';

class DeviceAPI {
  final String _changeStatusAPI = '/esps';
  final String _getDeviceInfo = '/device';
  final String _getDevicesType = '/devices/type';
  final String _updateDevice = '/devices/update';

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

  Future<DeviceModel?> getDeviceInfo (String id) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.get(
        Uri.https(APIConfig.baseServerAppURL, _getDeviceInfo, {'id': id}),
        headers: {
          // "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DeviceModel(
          data['idESP'] ?? '', 
          data['_id'] ?? '',
          data['pin'] ?? '',
          data['idRoom'] ?? '',
          data['roomName'] ?? '',
          data['deviceName'] ?? 'no_name',
          data['type'] ?? '',
          data['isConnected'] ?? false,
          data['status'] ?? 0
        );
      }
    } catch (err) { 
      print('[DeviceAPI][GetDeviceInfo]: $err');
      return null;
    }
  }

  Future<List<String>> getDeviceTypes() async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.get(
        Uri.https(APIConfig.baseServerAppURL, _getDevicesType),
        // headers: {
        //   "Authorization": token!
        // },
      );
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List.from(data.map((type) => type));
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[DeviceAPI][GetDeviceTypes]: $err');
      return List.empty();
    }
  }

  Future<bool> updateDeviceInfo(DeviceUpdateModel device) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.put(
        Uri.https(APIConfig.baseServerAppURL, _updateDevice),
        // headers: {
        //   "Authorization": token!
        // },
        body: {
          'id': device.id,
          'name': device.name,
          'type': device.type,
          'idRoom': device.idRoom,
        }
      );
      return response.statusCode == 200;
    } catch (err) {
      print('[DeviceAPI][UpdateDeviceInfo]: $err');
      return false;
    }
  }
}