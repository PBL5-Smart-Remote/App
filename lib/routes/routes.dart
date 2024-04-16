import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/pages/index_page.dart';
import 'package:smart_home_fe/pages/room_devices_page.dart';


class Routes {
  static late Map<String, Widget Function(BuildContext)> _route;

  static Map<String, Widget Function(BuildContext)> init(BuildContext context) {
    _route = {
      '/room': (context) => RoomDevicesPage(),
      '/index': (context) => IndexPage(),
    };
    return _route;
  }

}