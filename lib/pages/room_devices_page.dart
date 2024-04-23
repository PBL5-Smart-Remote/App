import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/view_models/room_view_model.dart';
import 'package:smart_home_fe/views/appbar_title.dart';
import 'package:smart_home_fe/views/device_view.dart';
import 'package:smart_home_fe/views/figure_icon_view.dart';

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
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FigureIconView(Icon(Icons.water_drop, color: Colors.blue[300]), "humidity", "75%"),
                          VerticalDivider(thickness: 1, width: 1, color: Colors.grey[200]),
                          FigureIconView(Icon(Icons.electric_bolt_rounded, color: Colors.blue[900]), "energy", "60kwh"),
                          VerticalDivider(thickness: 1, width: 1, color: Colors.grey[200]),
                          FigureIconView(Icon(Icons.thermostat_rounded, color: Colors.amber[900]), "temp", "24°C")
                        ],
                      )
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                        physics: const BouncingScrollPhysics(),
                        children:roomViewModel.room!.deviceList.map((device) => DeviceView(device, isEditable: true)).toList()
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