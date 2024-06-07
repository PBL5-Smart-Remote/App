import 'package:smart_home_fe/models/device_model.dart';

class ScheduleModel {
  String id;
  String name;
  List<DeviceModel>? devices;
  int hour;
  int minute;
  List<int> daysOfWeek;
  bool isActive;
  ScheduleModel({required this.id, required this.name, required this.devices, required this.hour, required this.minute, this.daysOfWeek = const [], this.isActive = true});
}