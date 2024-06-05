// ignore_for_file: prefer_for_elements_to_map_fromiterable, avoid_print

import 'package:dio/dio.dart';
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

  Future<Map<String, DeviceModel>> getAllDevices() async {
    try {
      String url = Uri.https(APIConfig.baseServerFirmwareURL, '$_getDevice/allDevices').toString();
      final response = await dio.get(
        url,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return Map.fromIterable(data, 
          key: (device) => device['_id'].toString(),
          value: (device) => DeviceModel(
            device['ESP'] ?? '',
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
          )
        );
      } else {
        return {};
      }
    } catch (err) {
      print('[DeviceAPI][GetAllDevices]: $err');
      return {};
    }
  }

  Future<bool> changeStatus(DeviceControlModel model) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      String url = Uri.https(APIConfig.baseServerFirmwareURL, _changeStatusAPI).toString();

      final response = await dio.post(
        url,
        options: Options(
          headers: {
            // "Authorization": token!,
            "Content-Type": "application/json",
          },
        ),
        data: {
          "devices": [ 
            {
              "_id": model.idDevice,
              "status": (model.status == 1 ? "on" : "off")
            }
          ]
        }
      );
      print(response.data);
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
      String url = Uri.https(APIConfig.baseServerFirmwareURL, '$_getDevice/$id').toString();
      final response = await dio.get(
        url,
        // options: Options(
        //   headers: {
        //     "Authorization": token!,
        //   },
        // )
      );
      if (response.statusCode == 200) {
        final device = response.data;
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
      String url = Uri.https(APIConfig.baseServerFirmwareURL, _getDevicesType).toString();
      final response = await dio.get(
        url,
        // options: Options(
        //   headers: {
        //     "Authorization": token!
        //   },
        // ),
      );
      if(response.statusCode == 200) {
        final data = response.data;
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
      String url = Uri.https(APIConfig.baseServerFirmwareURL, '$_updateDevice/${device.id}').toString();
      final response = await dio.put(
        url,
        // headers: {
        //   "Authorization": token!
        // },
        data: {
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
      String url = Uri.https(APIConfig.baseServerFirmwareURL, '$_getDeviceLabel/$type').toString();
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
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