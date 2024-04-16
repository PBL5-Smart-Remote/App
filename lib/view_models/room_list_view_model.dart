import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/services/room_service.dart';

class RoomListViewModel with ChangeNotifier {
  final _roomService = RoomService();

  List<RoomBriefModel> _rooms = List.empty();
  
  List<RoomBriefModel> get rooms => _rooms;

  Future<void> getRooms() async {
    try {
      _roomService.getRooms().then(
        (rooms) {
          _rooms = rooms;
          notifyListeners();
        });
    } catch (err) {
      print('[RoomListViewModel][GetRooms]: $err');
    }
  }

  // add room
}