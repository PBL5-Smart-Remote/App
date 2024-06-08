// ignore_for_file: prefer_for_elements_to_map_fromiterable, avoid_print

import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/add_schedule_model.dart';
import 'package:smart_home_fe/models/schedule_model.dart';
import 'package:dio/dio.dart';

class ScheduleAPI {
  final String _getSchedule = '/schedule/get';
  final String _addSchedule = '/schedule/add';
  final String _updateSchedule = '/schedule/update';
  final String _deleteSchedule = '/schedule/delete';

  final dio = Dio();

  Future<List<ScheduleModel>> getAllSchedule() async {
    try {
      final response = await dio.get(
        Uri.https(APIConfig.baseServerAppURL, '$_getSchedule/allSchedules').toString(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return List.from(data['schedules'].map((schedule) => ScheduleModel(
            id: schedule['_id'],
            name: schedule['name'],
            devices: schedule['devices'].map((device) => device['_id']).toList().cast<String>(),
            hour: schedule['time']['hour'] ?? 0,
            minute: schedule['time']['minute'] ?? 0,
            daysOfWeek: schedule['daysOfWeek'].cast<int>() ?? List.empty(),
            isActive: schedule['isActive'] ?? 0,
          )
        ));
      } else {
        return List.empty(); 
      }
    } catch (err) {
      print('[ScheduleAPI][GetAllSchedule]: $err');
      return List.empty();
    }
  }

  Future<ScheduleModel?> getScheduleById(String id) async {
    try {
      final response = await dio.get(
        Uri.https(APIConfig.baseServerAppURL, '$_getSchedule/$id').toString(),
      );
      if (response.statusCode == 200) {
        final schedule = response.data['schedule'];
        print(schedule);
        return ScheduleModel(
            id: schedule['_id'],
            name: schedule['name'],
            devices: schedule['devices'].map((device) => device['_id']).toList().cast<String>(),
            hour: schedule['time']['hour'] ?? 0,
            minute: schedule['time']['minute'] ?? 0,
            daysOfWeek: schedule['daysOfWeek'].cast<int>() ?? List.empty(),
            isActive: schedule['isActive'] ?? 0,
          )
        ;
      } else {
        return null; 
      }
    } catch (err) {
      print('[ScheduleAPI][GetAllSchedule]: $err');
      return null;
    }
  }

  Future<bool> addNewSchedule(AddUpdateScheduleModel schedule) async {
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

  Future<bool> updateSchedule(AddUpdateScheduleModel schedule) async {
    try {
      String url = Uri.https(APIConfig.baseServerAppURL, '$_updateSchedule/${schedule.id}').toString();
      final response = await dio.post(
        url,
        data: {
          'devices': schedule.devices.map((device) => { "_id" : device, 'status': 1 }).toList(),
          'name': schedule.name,
          'daysOfWeek': schedule.daysOfWeek,
          'time': {
            'hour': schedule.hour,
            'minute': schedule.minute,
          },
        }
      );
      print(response.data);
      return response.statusCode == 200;
    } catch(err) {
      print('[ScheduleAPI][UpdateNewSchedule]: $err');
      return false;
    }
  }

  Future<bool> changeStatusSchedule(String id, int status) async {
    try {
      String url = Uri.https(APIConfig.baseServerAppURL, '$_updateSchedule/$id/status').toString();
      final response = await dio.patch(
        url,
        data: {
          'isActive': status,
        }
      );
      print(response.data);
      return response.statusCode == 200;
    } catch(err) {
      print('[ScheduleAPI][ChangeStatusSchedule]: $err');
      return false;
    }
  }

  Future<bool> deleteSchedule(String id) async {
    try {
      String url = Uri.https(APIConfig.baseServerAppURL, '$_deleteSchedule/$id').toString();
      final response = await dio.delete(
        url,
      );
      print(response.data);
      return response.statusCode == 200;
    } catch(err) {
      print('[ScheduleAPI][DeleteSchedule]: $err');
      return false;
    }
  }
}