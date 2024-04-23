import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/models/room_model.dart';

class RoomAPI {
  final String _getRoomsAPI = "/rooms";

  Future<List<RoomBriefModel>> getRooms () async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.get(
        Uri.http(APIConfig.baseServerAppURL, _getRoomsAPI),
        // headers: {
        //   "Authorization": token!
        // },
      );
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return List.from(data.map((room) => RoomBriefModel(
          room['_id'],
          'https://media.architecturaldigest.com/photos/62f3c04c5489dd66d1d538b9/16:9/w_2560%2Cc_limit/_Hall_St_0256_v2.jpeg',
          room['name'],
          room['numDevices'],
          room['numConnected']
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
      final response = await http.get(
        Uri.http(APIConfig.baseServerAppURL, '$_getRoomsAPI/$id'),
        // headers: {
        //   "Authorization": token!
        // },
      );
      if(response.statusCode == 200) {
        final room = jsonDecode(response.body);
        return RoomModel(
          room['_id'],
          room['name'],
          List<DeviceModel>.from(room['devices'].map((device) => DeviceModel(
            device['_idESP'] ?? '',
            device['_id'] ?? '',
            device['pin'] ?? '',
            device['name'] ?? '_no_name_',
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
}