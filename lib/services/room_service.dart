import 'package:smart_home_fe/api/room_api.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/models/room_model.dart';

class RoomService {
  final roomAPI = RoomAPI();

  Future<List<RoomBriefModel>> getRooms() async {
    try {
      return await roomAPI.getRooms();
    } catch (err) {
      print('[RoomService][GetRooms]: $err');
      return List.empty();
    }
  }

  Future<RoomModel?> getRoomById(String id) async {
    try {
      return await roomAPI.getRoomById(id);
    } catch (err) {
      print('[RoomService][GetRoomById]: $err');
      return null;
    }
  }

  Future<List<(String, String)>> getRoomsInfo() async {
    try {
      return await roomAPI.getAllRoomInfo();
    } catch (err) { 
      print('[RoomService][GetRoomsInfo]: $err');
      return List.empty();
    }
  }
}