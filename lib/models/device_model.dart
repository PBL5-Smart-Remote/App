import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum DeviceStatus {
  off,
  on
}

final Map<String, dynamic> deviceType = {
  'LIGHT': { 
    'icon': const FaIcon(Icons.light, color: Colors.white),
    'colors': [const Color.fromRGBO(0, 219, 227, 1), const Color.fromRGBO(0, 183, 200, 1)],
  },
  'FAN': {
    'icon': const FaIcon(FontAwesomeIcons.fan, color: Colors.white),
    'colors': [const Color.fromRGBO(243, 131, 0, 1), const Color.fromRGBO(227, 55, 0, 1)],
  },
  'DOOR': {
    'icon': const FaIcon(FontAwesomeIcons.doorOpen, color: Colors.white),
    'colors': [const Color.fromRGBO(144, 77, 255, 1), const Color.fromRGBO(102, 50, 189, 1)],
  }
};

class DeviceModel {
  String idESP;
  String id; // id device lưu trong db, dùng để điều khiển
  String pin; // index của chân relay
  String idRoom;
  String roomName;
  String deviceName;
  String type;
  bool isConnected;
  int status;
  FaIcon icon = const FaIcon(Icons.device_unknown, color: Colors.white);
  List<Color> colors = [Colors.grey[200]!, Colors.grey[300]!];


  DeviceModel(this.idESP, this.id, this.pin, this.idRoom, this.roomName, this.deviceName,  this.type, this.isConnected, this.status) {
    icon = deviceType[type]['icon'];
    colors = deviceType[type]['colors'];
  }
}