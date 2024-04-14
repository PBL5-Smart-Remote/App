import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/pages/index_page.dart';
import 'package:smart_home_fe/pages/login_page.dart';
import 'package:smart_home_fe/pages/register_page.dart';

class Routes {
  static late Map<String, Widget Function(BuildContext)> _route;

  static Map<String, Widget Function(BuildContext)> init(BuildContext context) {
    _route = {
      '/login' : (context) => LoginPage(),
      '/register' : (context) => RegisterPage(),
      '/index': (context) => IndexPage(),
    };
    return _route;
  }

}