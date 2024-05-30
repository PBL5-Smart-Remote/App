import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_fe/models/device_label_model.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_update_model.dart';

class DeviceAPI {
  final String _getDevice = '/devices';
  final String _changeStatusAPI = '/devices/changeStatus';
  final String _updateDevice = '/devices/update';
  final String _getDevicesType = '/devices/type';
  final String _getDeviceLabel = '/labels';
  final dio = Dio();
  Future<List<DeviceModel>> getAllDevices() async {
    try {
      final response = await dio.get(
        Uri.http(APIConfig.baseServerFirmwareURL, '$_getDevice/allDevices').toString(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return List.from(data.map((device) => DeviceModel(
          device['ESP']['_idESP'] ?? '',
          device['_id'] ?? '',
          device['pin'] ?? '',
          device['room']['_id'] ?? '',
          device['room']['name'] ?? '', 
          device['name'] ?? 'no_name',
          device['label']['_id'] ?? '', 
          device['label']['label'] ?? '',
          device['type'] ?? '',
          device['isConnected'] ?? false,
          device['status'] ?? 0
        )));
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[DeviceAPI][GetAllDevices]: $err');
      return List.empty();
    }
  }

  Future<bool> changeStatus(DeviceControlModel model) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      var url = APIConfig.baseServerFirmwareURL + _changeStatusAPI;
      print(url);
      final response = await http.post(
        Uri.https(APIConfig.baseServerFirmwareURL, _changeStatusAPI),
        headers: {
          // "Authorization": token!,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "devices": [ 
            {
              "_id": model.idDevice,
              "status": (model.status == 1 ? "on" : "off")
            }
          ]
        })
      );
      print(response.statusCode);
      return response.statusCode == 200;
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
        Uri.https(APIConfig.baseServerFirmwareURL, '$_getDevice/$id'),
        headers: {
          // "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final device = jsonDecode(response.body);
        // print(device);
        return DeviceModel(
          device['ESP']['_idESP'] ?? '', 
          device['_id'] ?? '',
          device['pin'] ?? '',
          device['room']['_id'] ?? '',
          device['room']['name'] ?? '',
          device['name'] ?? 'no_name',
          device['label']['_id'] ?? '',
          device['label']['label'] ?? '',
          device['type'] ?? '',
          device['isConnected'] ?? false,
          device['status'] ?? 0
        );
      } else {
        return null;
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
        Uri.https(APIConfig.baseServerFirmwareURL, _getDevicesType),
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
        Uri.https(APIConfig.baseServerFirmwareURL, '$_updateDevice/${device.id}'),
        // headers: {
        //   "Authorization": token!
        // },
        body: {
          'name': device.name,
          'label': device.idLabel,
          // 'idRoom': device.idRoom,
        }
      );
      return response.statusCode == 200;
    } catch (err) {
      print('[DeviceAPI][UpdateDeviceInfo]: $err');
      return false;
    }
  }

  Future<List<DeviceLabelModel>> getLabelByDeviceType(String type) async {
    try {
      final response = await dio.get(
        Uri.http(APIConfig.baseServerFirmwareURL, '$_getDeviceLabel/$type').toString(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        // print(data);
        return List.from(data['labels'].map((label) => DeviceLabelModel(
          label['_id'] ?? '',
          label['label'] ?? '',
          label['type'] ?? ''
        )));
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[DeviceAPI][GetLabelByDeviceType]: $err');
      return List.empty();
    }
  }
}