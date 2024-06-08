// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/models/device_label_model.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_update_model.dart';
import 'package:smart_home_fe/services/device_service.dart';

class DeviceViewModel with ChangeNotifier {
  final DeviceService _deviceService = DeviceService();

  List<DeviceModel> _devices = List.empty();
  List<DeviceModel> get devices => _devices;

  Future<List<DeviceModel>> getDevices() async {
    try {
      _devices = await _deviceService.getAllDevices();
      notifyListeners();
      return _devices;
    } catch (err) {
      print('[DeviceListViewModel][GetRooms]: $err');
      return List.empty();
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

  Future<List<DeviceLabelModel>> getDeviceLabels(String type) async {
    try {
      return await _deviceService.getLabelByDeviceType(type);
    } catch (err) {
      print('[DeviceViewModel][InitDeviceInfo]: $err');
      return List.empty();
    }
  }



  Future<DeviceModel?> getDeviceInfo(String id) async {
    try {
      return await _deviceService.getDeviceInfo(id);
    } catch (err) {
      print('[DeviceViewModel][GetDeviceInfo]: $err');
      return null;
    }
  }

  Future<bool> updateDeviceInfo(DeviceModel device) async {
    try {
      if (await _deviceService.updateDeviceInfo(device)) {
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