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

class ESPListViewModel with ChangeNotifier{
  final ESPService _espService = ESPService();
  
  List<ESPModel> _esps = List.empty();

  List<ESPModel> get esps => _esps;

  Future<void> getESPs() async {
    try {
      _espService.getESPs().then((esps) {
        _esps = esps;
        notifyListeners();
      });
    } catch (err) {
      print('[DeviceListViewModel][GetRooms]: $err');
    }
  }


}