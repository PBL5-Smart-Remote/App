import 'package:smart_home_fe/models/device_model.dart';

class ESPModel {
  String id; // id lưu trong db
  String idESP; // id của chính esp
  bool isConnected;
  List<DeviceModel> devices;

  ESPModel(this.id, this.idESP, this.isConnected, this.devices);
}