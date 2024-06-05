import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/schedule_model.dart';
import 'package:smart_home_fe/services/schedule_service.dart';

class ScheduleViewModel with ChangeNotifier {
  final scheduleService = ScheduleService();

  Map<String, ScheduleModel> _schedules = {}; 
  Map<String, ScheduleModel>  get schedules => _schedules; 
  
  Future<void> getAllSchedules() async {
    try {
      _schedules = await scheduleService.getAllSchedule();
      notifyListeners();
    } catch (err) {
      print('[ScheduleViewModel][GetAllSchedule]: $err');
    }
  }
}