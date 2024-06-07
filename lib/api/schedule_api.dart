// ignore_for_file: prefer_for_elements_to_map_fromiterable, avoid_print

import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/add_schedule_model.dart';
import 'package:smart_home_fe/models/schedule_model.dart';
import 'package:dio/dio.dart';

class ScheduleAPI {
  final String _getSchedule = '/schedule/get';
  final String _addSchedule = '/schedule/add';

  final dio = Dio();

  Future<Map<String, ScheduleModel>> getAllSchedule() async {
    try {
      final response = await dio.get(
        Uri.https(APIConfig.baseServerAppURL, '$_getSchedule/allSchedules').toString(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return Map.fromIterable(data['schedules'], 
          key : (schedule) => schedule['_id'].toString(),
          value : (schedule) => ScheduleModel(
            id: schedule['_id'],
            name: schedule['name'],
            devices: null,
            hour: schedule['time']['hour'] ?? 0,
            minute: schedule['time']['minute'] ?? 0,
            daysOfWeek: schedule['daysOfWeek'].cast<int>() ?? List.empty(),
            isActive: schedule['isActive'] != null ? schedule['isActive'] == 1 : false,
          )
        );
      } else {
        return {}; 
      }
    } catch (err) {
      print('[ScheduleAPI][GetAllSchedule]: $err');
      return {};
    }
  }

  Future<bool> addNewSchedule(AddScheduleModel schedule) async {
    try {
      String url = Uri.https(APIConfig.baseServerAppURL, _addSchedule).toString();
      final response = await dio.post(
        url,
        data: {
          'devices': schedule.devices.map((device) => { "_id" : device, 'status': 1 }).toList(),
          'name': schedule.name,
          'daysOfWeek': schedule.daysOfWeek,
          'time': {
            'hour': schedule.hour,
            'minute': schedule.minute,
          }
        }
      );
      print(response.data);
      return response.statusCode == 200;
    } catch(err) {
      print('[ScheduleAPI][AddNewSchedule]: $err');
      return false;
    }
  }
}