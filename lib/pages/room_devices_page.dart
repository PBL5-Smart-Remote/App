import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:smart_home_fe/view_models/room_view_model.dart';
import 'package:smart_home_fe/views/device_view.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';
import 'package:smart_home_fe/utils/widget/figure_icon_view.dart';
import 'package:smart_home_fe/views/sensor_view.dart';

class RoomDevicesPage extends StatefulWidget {
  RoomDevicesPage({super.key});

  @override
  State<RoomDevicesPage> createState() => _RoomDevicesPageState();
}

class _RoomDevicesPageState extends State<RoomDevicesPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Provider.of<RoomViewModel>(context, listen: false).getRoomById(args['id']);
    return Consumer<RoomViewModel>(
      builder: (context, roomViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: AppBarTitle(roomViewModel.room == null ? "" : roomViewModel.room!.roomName),
          ),
          body: roomViewModel.room == null 
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color.fromRGBO(244, 247, 255, 1), Color.fromRGBO(229, 236, 248, 1)])
                ),
                child: Column(
                  children: [
                    const SensorView(),
                    const SizedBox(height: 30),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                        physics: const BouncingScrollPhysics(),
                        children: roomViewModel.room!.deviceList.map((device) => DeviceView(device, isEditable: true)).toList()
                      ),
                    )
                  ],
                ),
              )
        );
      },
    );
  }
}