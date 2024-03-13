import 'package:smart_home_fe/api/device_api.dart';
import 'package:smart_home_fe/api/esp_api.dart';
import 'package:smart_home_fe/api/room_api.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/models/device_model.dart';

class DeviceService {
  final DeviceAPI deviceAPI = DeviceAPI();

  Future<bool> changeStatus(DeviceControlModel device) async {
    try {
      return await deviceAPI.changeStatus(device);
    } catch (err) {
      print('[DeviceService][ChangeStatus]: $err');
      return false;
    }
  }
}