// ignore_for_file: prefer_for_elements_to_map_fromiterable, avoid_print

import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/schedule_model.dart';
import 'package:dio/dio.dart';

class ScheduleAPI {
  final String _getSchedule = '/schedule/get';

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
            devices: null,
            hour: schedule['time']['hour'] ?? 0,
            minute: schedule['time']['minute'] ?? 0,
            daysOfWeek: schedule['daysOfWeek'].cast<int>() ?? List.empty(),
            isActive: schedule['isActive'] != null ? schedule['isActive'] == 1 : false,
          )
        );
        // return List.from(data['schedules'].map((schedule) => ScheduleModel(
        //    devices: null,
        //    hour: schedule['time']['hour'] ?? 0,
        //    minute: schedule['time']['minute'] ?? 0,
        //    daysOfWeek: schedule['daysOfWeek'] ?? List.empty(),
        //    isActive: schedule['isActive'] ?? false,
        // )));
      } else {
        return {}; 
      }
    } catch (err) {
      print('[ScheduleAPI][GetAllSchedule]: $err');
      return {};
    }
  }
}