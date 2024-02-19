import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeviceBriefModel {
  late String deviceName;
  late String roomName;
  late String type;
  late bool isConnected;
  late bool isActive;
  late FaIcon icon;
  late List<Color> colors;

  DeviceBriefModel(this.deviceName, this.roomName, this.type) {
    isConnected = false;
    isActive = false;
    switch(type) {
      case "Light": {
        icon = const FaIcon(Icons.light, color: Colors.white);
        colors = [const Color.fromRGBO(0, 219, 227, 1), const Color.fromRGBO(0, 183, 200, 1)];
        break;
      }
      case "Fan": {
        icon = const FaIcon(FontAwesomeIcons.fan, color: Colors.white);
        colors = [const Color.fromRGBO(243, 131, 0, 1), const Color.fromRGBO(227, 55, 0, 1)];
        break;
      }
      case "Door": {
        icon = const FaIcon(FontAwesomeIcons.doorOpen, color: Colors.white);
        colors = [const Color.fromRGBO(144, 77, 255, 1), const Color.fromRGBO(102, 50, 189, 1)];
        break;
      }
    }
  }
}