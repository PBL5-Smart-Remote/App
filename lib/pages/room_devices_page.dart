import 'package:flutter/material.dart';
import 'package:smart_home_fe/widgets/appbar_title.dart';
import 'package:smart_home_fe/widgets/figure_icon.dart';

class RoomDevicesPage extends StatefulWidget {
  late String roomName;
  RoomDevicesPage(this.roomName, {super.key});

  @override
  State<RoomDevicesPage> createState() => _RoomDevicesPageState();
}

class _RoomDevicesPageState extends State<RoomDevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(widget.roomName),
      ),
      body: Container(
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
                  FigureIcon(Icon(Icons.water_drop, color: Colors.blue[300]), "humidity", "75%"),
                  VerticalDivider(thickness: 1, width: 1, color: Colors.grey[200]),
                  FigureIcon(Icon(Icons.electric_bolt_rounded, color: Colors.blue[900]), "energy", "60kwh"),
                  VerticalDivider(thickness: 1, width: 1, color: Colors.grey[200]),
                  FigureIcon(Icon(Icons.thermostat_rounded, color: Colors.amber[900]), "temp", "24°C")
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}