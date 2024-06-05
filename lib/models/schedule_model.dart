import 'package:smart_home_fe/models/device_model.dart';

class ScheduleModel {
  String id;
  List<DeviceModel>? devices;
  int hour;
  int minute;
  List<int> daysOfWeek;
  bool isActive;
  ScheduleModel({required this.id, required this.devices, required this.hour, required this.minute, this.daysOfWeek = const [], this.isActive = true});
}