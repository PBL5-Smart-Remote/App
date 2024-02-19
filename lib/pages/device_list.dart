import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/device_brief_model.dart';
import 'package:smart_home_fe/widgets/device_card.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          physics: const BouncingScrollPhysics(),
          children: [
            DeviceCard(DeviceBriefModel("Light 1", "Living room", "Light")),
            DeviceCard(DeviceBriefModel("Light 2", "Living room", "Light")),
            DeviceCard(DeviceBriefModel("Fan 1", "Living room", "Fan")),
            DeviceCard(DeviceBriefModel("Fan 2", "Living room", "Fan")),
            DeviceCard(DeviceBriefModel("Door 1", "Living room", "Door")),
            DeviceCard(DeviceBriefModel("Door 2", "Living room", "Door")),
          ],
        )
    );
  }
}