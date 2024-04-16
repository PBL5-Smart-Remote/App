import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/pages/index_page.dart';
import 'package:smart_home_fe/routes/routes.dart';
import 'package:smart_home_fe/view_models/connection_view_model.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';
import 'package:smart_home_fe/view_models/esp_list_view_model.dart';
import 'package:smart_home_fe/view_models/room_list_view_model.dart';
import 'package:smart_home_fe/view_models/room_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceViewModel>(create: (_) => DeviceViewModel()),
        ChangeNotifierProvider<ESPListViewModel>(create: (_) => ESPListViewModel()),
        ChangeNotifierProvider<ConnectionViewModel>(create: (_) => ConnectionViewModel()),
        ChangeNotifierProvider<RoomListViewModel>(create: (_) => RoomListViewModel()),
        ChangeNotifierProvider<RoomViewModel>(create: (_) => RoomViewModel()), 
      ],
      child: MaterialApp(
        initialRoute: '/index',
        routes: Routes.init(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
