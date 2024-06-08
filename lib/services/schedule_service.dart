import 'package:smart_home_fe/api/schedule_api.dart';
import 'package:smart_home_fe/models/add_schedule_model.dart';
import 'package:smart_home_fe/models/schedule_model.dart';

class ScheduleService {
  final scheduleAPI = ScheduleAPI();

  Future<List<ScheduleModel>> getAllSchedule() async {
    try {
      return await scheduleAPI.getAllSchedule();
    } catch (err) {
      print('[ScheduleService][GetAllSchedule]: $err');
      return List.empty();
    }
  }

  Future<ScheduleModel?> getScheduleById(String id) async {
    try {
      return await scheduleAPI.getScheduleById(id);
    } catch (err) {
      print('[ScheduleService][GetAllSchedule]: $err');
      return null;
    }
  }

  Future<bool> addNewSchedule(AddUpdateScheduleModel schedule) async {
    try {
      return await scheduleAPI.addNewSchedule(schedule);
    } catch (err) {
      print('[ScheduleService][AddNewSchedule]: $err');
      return false;
    }
  }

  Future<bool> updateSchedule(AddUpdateScheduleModel schedule) async {
    try {
      return await scheduleAPI.updateSchedule(schedule);
    } catch (err) {
      print('[ScheduleService][UpdateSchedule]: $err');
      return false;
    }
  }

  Future<bool> changeStatusSchedule(String id, int status) async {
    try {
      return await scheduleAPI.changeStatusSchedule(id, status);
    } catch (err) {
      print('[ScheduleService][ChangeStatusSchedule]: $err');
      return false;
    }
  }

  Future<bool> deleteSchedule(String id) async {
    try {
      return await scheduleAPI.deleteSchedule(id);
    } catch (err) {
      print('[ScheduleService][DeleteSchedule]: $err');
      return false;
    }
  }
}