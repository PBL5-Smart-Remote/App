import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/models/device_label_model.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_update_model.dart';
import 'package:smart_home_fe/services/device_service.dart';

class DeviceViewModel with ChangeNotifier {
  final DeviceService _deviceService = DeviceService();

  List<DeviceLabelModel> deviceLabels = List.empty(growable: false);
  Map<String, DeviceModel> _devices = {};
  Map<String, DeviceModel> get devices => _devices;

  Future<void> getDevices() async {
    try {
      _devices = await _deviceService.getAllDevices();
      notifyListeners();
    } catch (err) {
      print('[DeviceListViewModel][GetRooms]: $err');
    }
  }

  Future<bool> changeStatus(DeviceControlModel device) async {
    try {
      // _devices[device.idDevice]!.status = device.status;
      // notifyListeners();
      await _deviceService.changeStatus(device);
      return true;
    } catch (err) {
      print('[DeviceViewModel][ChangeStatus]: $err');
      return false;
    }
  }

  Future<void> getDeviceLabels(String type) async {
    try {
      _deviceService.getLabelByDeviceType(type).then((value)  {
        deviceLabels = value;
        print(deviceLabels);
        notifyListeners();
      });
    } catch (err) {
      print('[DeviceViewModel][InitDeviceInfo]: $err');
    }
  }

  void clearData() {
    try {
      deviceLabels = List.empty();
    } catch (err) {
      print('[DeviceViewModel][ClearData]: $err');
    }
  }

  // Future<void> getDeviceInfo(String id) async {
  //   try {
  //     // _deviceService.getDeviceInfo(id).then((value) {
  //     //   print(value);
  //     //   _device = value;
  //     // notifyListeners();
  //     // });
  //     _device = await _deviceService.getDeviceInfo(id);
  //     print(_device);
  //     notifyListeners();
  //   } catch (err) {
  //     print('[DeviceViewModel][GetDeviceInfo]: $err');
  //   }
  // }

  Future<bool> updateDeviceInfo(DeviceUpdateModel device) async {
    try {
      if ( await _deviceService.updateDeviceInfo(device)) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('[DeviceViewModel][UpdateDeviceInfo]: $err');
      return false;
    }
  }

}