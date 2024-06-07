// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/models/room_model.dart';

class RoomAPI {

  final String _getRoomsInfo = '/rooms';

  final dio = Dio();

  Future<List<RoomBriefModel>> getRooms () async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      String url = Uri.https(APIConfig.baseServerAppURL, '$_getRoomsInfo/allRooms').toString();

      final response = await dio.get(
        url,
        // options: Options(
        //   headers: { 
        //     "Authorization": token!
        //   },
        // ),
      );
      if(response.statusCode == 200) {
        final data = response.data;
        print(data['rooms']);
        return List.from(data['rooms'].map((room) => RoomBriefModel(
          room['_id'],
          room['image'] ?? 'https://media.architecturaldigest.com/photos/62f3c04c5489dd66d1d538b9/16:9/w_2560%2Cc_limit/_Hall_St_0256_v2.jpeg',
          room['name'],
          int.parse(room['numDevices']), 
          int.parse(room['numConnected'])
        )));
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[RoomAPI][GetRooms]: $err');
      return List.empty();
    }
  } 

  Future<RoomModel?> getRoomById(String id) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      String url = Uri.https(APIConfig.baseServerAppURL, '$_getRoomsInfo/$id').toString();

      final response = await dio.get(
        url,
        // options: Options(
        //   headers: {
        //     "Authorization": token!
        //   },
        // ),
      );
      if(response.statusCode == 200) {
        final room = response.data['room'];
        print(room);
        return RoomModel(
          room['_id'],
          room['name'],
          List<DeviceModel>.from(room['devices'].map((device) => DeviceModel(
            device['ESP'] ?? '',
            device['_id'] ?? '',
            device['pin'] ?? '',
            room['_id'] ?? '',
            room['name'] ?? '',
            device['name'] ?? 'no_name',
            device['idDeviceLabel'] ?? '', 
            device['deviceLabel'] ?? '',
            device['type'] ?? '',
            device['isConnected'] ?? false,
            device['status'] ?? 0
          )))
        );
      } else {
        return null;
      }
    } catch (err) {
      print('[RoomAPI][GetRoomByID]: $err');
      return null;
    }
  }

  // get room info for dropdown
  Future<List<(String, String)>> getAllRoomInfo() async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      String url = Uri.https(APIConfig.baseServerAppURL, _getRoomsInfo).toString();

      final response = await dio.get(
        url,
        // options: Options(
        //   headers: {
        //     "Authorization": token!
        //   },
        // ),
      );
      if(response.statusCode == 200) {
        final data = response.data;
        return List.from(data.map((room) => (room['_id'], room['name'])));
      } else {
        return List.empty();
      }
    } catch (err) {
      print('[RoomAPI][GetAllRoomInfo]: $err');
      return List.empty();
    }
  }
}