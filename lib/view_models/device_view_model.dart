import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/services/device_service.dart';

class DeviceViewModel with ChangeNotifier {
  final DeviceService _deviceService = DeviceService();

  Future<bool> changeStatus(DeviceControlModel device) async {
    try {
      await _deviceService.changeStatus(device);
      notifyListeners();
      return true;
    } catch (err) {
      print('[DeviceListViewModel][ChangeStatus]: $err');
      return false;
    }
  }
}