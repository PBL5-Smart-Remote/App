import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/pages/add_schedule_page.dart';
import 'package:smart_home_fe/pages/edit_device_page.dart';
import 'package:smart_home_fe/pages/room_page.dart';
import 'package:smart_home_fe/pages/change_password.dart';
import 'package:smart_home_fe/pages/index_page.dart';
import 'package:smart_home_fe/pages/login_page.dart';
import 'package:smart_home_fe/pages/register_page.dart';
import 'package:smart_home_fe/pages/update_schedule_page.dart';
import 'package:smart_home_fe/pages/user_info_page.dart';

class Routes {
  static late Map<String, Widget Function(BuildContext)> _route;

  static Map<String, Widget Function(BuildContext)> init(BuildContext context) {
    _route = {
      '/room': (context) => RoomPage(),
      '/edit-device': (context) => const EditDevicePage(),
      '/login' : (context) => const LoginPage(),
      '/register' : (context) => const RegisterPage(),
      '/index': (context) => const IndexPage(),
      '/user-info': (context) => const UserInfoPage(),
      '/change-password': (context) => const ChangePasswordPage(),
      '/add-schedule': (context) => const AddSchedulePage(),
      '/update-schedule': (context) => const UpdateSchedulePage(),
    };
    return _route;
  }
}