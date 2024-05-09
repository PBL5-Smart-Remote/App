import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/api/device_api.dart';
import 'package:smart_home_fe/api/esp_api.dart';
import 'package:smart_home_fe/api/room_api.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/models/esp_model.dart';
import 'package:smart_home_fe/services/device_service.dart';
import 'package:smart_home_fe/services/esp_service.dart';

class DeviceListViewModel with ChangeNotifier{
  final DeviceService _deviceService = DeviceService();
  
  List<DeviceModel> _devices = List.empty();

  List<DeviceModel> get devices => _devices;

  Future<void> getDevices() async {
    try {
      _deviceService.getAllDevices().then((devices) {
        _devices = devices;
        notifyListeners();
      });
    } catch (err) {
      print('[DeviceListViewModel][GetRooms]: $err');
    }
  }


}