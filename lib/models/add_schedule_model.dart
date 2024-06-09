class AddUpdateScheduleModel {
  String? id;
  String name;
  List<({String id, int status})> devices = [];
  int hour;
  int minute;
  List<int> daysOfWeek = [];
  AddUpdateScheduleModel({required this.id, required this.name, required this.devices, required this.hour, required this.minute, required this.daysOfWeek});
}