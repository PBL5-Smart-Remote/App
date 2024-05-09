import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/pages/index_page.dart';
import 'package:smart_home_fe/routes/routes.dart';
import 'package:smart_home_fe/services/user_service.dart';
import 'package:smart_home_fe/view_models/connection_view_model.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';
import 'package:smart_home_fe/view_models/device_list_view_model.dart';
import 'package:smart_home_fe/view_models/room_list_view_model.dart';
import 'package:smart_home_fe/view_models/room_view_model.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  final userService = UserService();
  userService.verifyToken().then(
    (value) => runApp(MyApp(value))
  );
}

class MyApp extends StatelessWidget {
  bool isValidToken;
  MyApp(this.isValidToken, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceViewModel>(create: (_) => DeviceViewModel()),
        ChangeNotifierProvider<DeviceListViewModel>(create: (_) => DeviceListViewModel()),
        ChangeNotifierProvider<ConnectionViewModel>(create: (_) => ConnectionViewModel()),
        ChangeNotifierProvider<RoomListViewModel>(create: (_) => RoomListViewModel()),
        ChangeNotifierProvider<RoomViewModel>(create: (_) => RoomViewModel()), 
      ],
      child: MaterialApp(
        initialRoute: isValidToken ? '/index': '/login',
        routes: Routes.init(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
