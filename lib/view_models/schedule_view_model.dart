// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/add_schedule_model.dart';
import 'package:smart_home_fe/models/schedule_model.dart';
import 'package:smart_home_fe/services/schedule_service.dart';

class ScheduleViewModel with ChangeNotifier {
  final scheduleService = ScheduleService();

  List<ScheduleModel> _schedules = List.empty(); 
  List<ScheduleModel>  get schedules => _schedules; 
  
  Future<void> getAllSchedules() async {
    try {
      scheduleService.getAllSchedule().then((value) {
        _schedules = value;
        notifyListeners();
      });
    } catch (err) {
      print('[ScheduleViewModel][GetAllSchedule]: $err');
    }
  }

  Future<ScheduleModel?> getScheduleById(String id) async {
    try {
      return await scheduleService.getScheduleById(id);
    } catch (err) {
      print('[ScheduleViewModel][GetAllSchedule]: $err');
      return null;
    }
  }

  Future<bool> addNewSchedule(AddUpdateScheduleModel schedule) async {
    try {
      return await scheduleService.addNewSchedule(schedule);
    } catch (err) {
      print('[ScheduleViewModel][AddNewSchedule]: $err');
      return false;
    }
  }

  Future<bool> updateSchedule(AddUpdateScheduleModel schedule) async {
    try {
      return await scheduleService.updateSchedule(schedule);
    } catch (err) {
      print('[ScheduleViewModel][UpdateSchedule]: $err');
      return false;
    }
  }

  Future<bool> changeStatusSchedule(String id, int status) async {
    try {
      return await scheduleService.changeStatusSchedule(id, status);
    } catch (err) {
      print('[ScheduleViewModel][ChangeStatusSchedule]: $err');
      return false;
    }
  }

  Future<bool> deleteSchedule(String id) async {
    try {
      return await scheduleService.deleteSchedule(id);
    } catch (err) {
      print('[ScheduleViewModel][DeleteSchedule]: $err');
      return false;
    }
  }
}