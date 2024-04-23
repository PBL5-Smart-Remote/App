import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/pages/edit_device_page.dart';
import 'package:smart_home_fe/pages/room_devices_page.dart';
import 'package:smart_home_fe/pages/change_password.dart';
import 'package:smart_home_fe/pages/index_page.dart';
import 'package:smart_home_fe/pages/login_page.dart';
import 'package:smart_home_fe/pages/register_page.dart';
import 'package:smart_home_fe/pages/user_info_page.dart';

class Routes {
  static late Map<String, Widget Function(BuildContext)> _route;

  static Map<String, Widget Function(BuildContext)> init(BuildContext context) {
    _route = {
      '/room': (context) => RoomDevicesPage(),
      '/edit-device': (context) => EditDevicePage(),
      '/login' : (context) => LoginPage(),
      '/register' : (context) => RegisterPage(),
      '/index': (context) => IndexPage(),
      '/user-info': (context) => UserInfoPage(),
      '/change-password': (context) => ChangePasswordPage(),
    };
    return _route;
  }
}