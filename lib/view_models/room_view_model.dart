import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/room_model.dart';
import 'package:smart_home_fe/services/device_service.dart';
import 'package:smart_home_fe/services/room_service.dart';

class RoomViewModel with ChangeNotifier {
  final deviceService = DeviceService();
  final roomService = RoomService();

  RoomModel? _room;

  RoomModel? get room => _room;

  Future<void> getRoomById(String id) async {
    try {
      roomService.getRoomById(id).then(
        (room) {
          _room = room;
          notifyListeners();
      });
    } catch (err) {
      print('[RoomViewModel][GetRoomById]: $err');
    }
  }

  // add device
}