import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/models/device_label_model.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_update_model.dart';
import 'package:smart_home_fe/services/device_service.dart';
import 'package:smart_home_fe/services/room_service.dart';

class DeviceViewModel with ChangeNotifier {
  final DeviceService _deviceService = DeviceService();
  final RoomService _roomService = RoomService();

  DeviceModel? _device;

  DeviceModel? get device => _device;

  List<DeviceLabelModel> deviceLabels = List.empty(growable: true);
  // List<(String, String)> roomsInfo = List.empty(growable: true);

  Future<bool> changeStatus(DeviceControlModel device) async {
    try {
      await _deviceService.changeStatus(device);
      notifyListeners();
      return true;
    } catch (err) {
      print('[DeviceViewModel][ChangeStatus]: $err');
      return false;
    }
  }

  Future<void> getDeviceLabels(String type) async {
    try {
      // roomsInfo = await _roomService.getRoomsInfo();
      deviceLabels = await _deviceService.getLabelByDeviceType(type);
      print(deviceLabels);
      // notifyListeners();

      // _deviceService.getLabelByDeviceType(type).then((value)  {
      //   deviceLabels = value;
      //   print(deviceLabels);
      //   getDeviceInfo(id);
      //   notifyListeners();
      // });
    } catch (err) {
      print('[DeviceViewModel][InitDeviceInfo]: $err');
    }
  }

  void clearData() {
    try {
      _device = null;
    } catch (err) {
      print('[DeviceViewModel][ClearData]: $err');
    }
  }

  Future<void> getDeviceInfo(String id) async {
    try {
      // _deviceService.getDeviceInfo(id).then((value) {
      //   print(value);
      //   _device = value;
      // notifyListeners();
      // });
      _device = await _deviceService.getDeviceInfo(id);
      print(_device);
      notifyListeners();
    } catch (err) {
      print('[DeviceViewModel][GetDeviceInfo]: $err');
    }
  }

  Future<bool> updateDeviceInfo(DeviceUpdateModel device) async {
    try {
      return await _deviceService.updateDeviceInfo(device);
    } catch (err) {
      print('[DeviceViewModel][UpdateDeviceInfo]: $err');
      return false;
    }
  }

}