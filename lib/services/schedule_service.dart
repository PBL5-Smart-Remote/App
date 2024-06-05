import 'package:smart_home_fe/api/schedule_api.dart';
import 'package:smart_home_fe/models/schedule_model.dart';

class ScheduleService {
  final scheduleAPI = ScheduleAPI();

  Map<String, ScheduleModel> schedules = {};

  Future<Map<String, ScheduleModel>> getAllSchedule() async {
    try {
      return await scheduleAPI.getAllSchedule();
    } catch (err) {
      print('[ScheduleService][GetAllSchedule]: $err');
      return {};
    }
  }
}