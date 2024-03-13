import 'package:smart_home_fe/models/device_model.dart';

class RoomModel {
  String roomID;
  String roomName;
  List<DeviceModel> deviceList;

  RoomModel(this.roomID, this.roomName, this.deviceList);
}