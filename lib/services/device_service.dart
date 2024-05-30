import 'package:smart_home_fe/api/device_api.dart';
import 'package:smart_home_fe/api/esp_api.dart';
import 'package:smart_home_fe/api/room_api.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/models/device_label_model.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_update_model.dart';

class DeviceService {
  final deviceAPI = DeviceAPI();

  Future<List<DeviceModel>> getAllDevices() async {
    try {
      return await deviceAPI.getAllDevices();
    } catch (err) {
      print('[DeviceService][GetAllDevices]: $err');
      return List.empty();
    }
  }

  Future<bool> changeStatus(DeviceControlModel device) async {
    try {
      return await deviceAPI.changeStatus(device);
    } catch (err) {
      print('[DeviceService][ChangeStatus]: $err');
      return false;
    }
  }
  
  Future<List<String>> getDeviceTypes() async {
    try {
      return await deviceAPI.getDeviceTypes();
    } catch(err) {
      print('[DeviceService][GetDeviceTypes]: $err');
      return List.empty();
    }
  }

  Future<DeviceModel?> getDeviceInfo(String id) async {
    try {
      return await deviceAPI.getDeviceInfo(id);
    } catch (err) {
      print('[DeviceService][GetDeviceInfo]: $err');
    }
  }

  Future<bool> updateDeviceInfo(DeviceUpdateModel device) async {
    try {
      return await deviceAPI.updateDeviceInfo(device);
    } catch (err) {
      print('[DeviceService][UpdateDeviceInfo]: $err');
      return false;
    }
  }

  Future<List<DeviceLabelModel>> getLabelByDeviceType(String type) async {
    try {
      return await deviceAPI.getLabelByDeviceType(type);
    } catch (err) {
      print('[DeviceService][GetLabelByDeviceType]: $err');
      return List.empty();
    }
  }
}