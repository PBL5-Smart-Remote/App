class AddScheduleModel {
  String name;
  List<String> devices = [];
  int hour;
  int minute;
  List<int> daysOfWeek = [];
  AddScheduleModel({required this.name, required this.devices, required this.hour, required this.minute, required this.daysOfWeek});
}