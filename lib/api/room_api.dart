import 'dart:convert';

import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/room_model.dart';

class RoomAPI {
  final String _getRoomsAPI = "/rooms";
  
  get http => null;

  // Future<List<RoomModel>> getRooms () async {
  //   try {
  //     // var prefs = await SharedPreferences.getInstance();
  //     // var token = prefs.getString('token');
  //     final response = await http.get(
  //       Uri.http(APIConfig.baseServerAppURL, _getRoomsAPI),
  //       // headers: {
  //       //   "Authorization": token!
  //       // },
  //     );
  //     print( Uri.http(APIConfig.baseServerAppURL + _getRoomsAPI));
  //     if(response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return List.from(data.map((room) => RoomModel(
  //         room['roomID'],
  //         room['roomName'],
  //         List.from(room['devices'].map((device) => DeviceModel(
  //           device['deviceID'],
  //           device['deviceName'],
  //           device['type'],
  //           device['isConnected'],
  //           device['status']
  //         )))
  //       )));
  //     } else {
  //       return List.empty();
  //     }
  //   } catch (err) {
  //     print('[RoomAPI][GetRooms]: $err');
  //     return List.empty();
  //   }
  // } 
}