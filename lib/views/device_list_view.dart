import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';
import 'package:smart_home_fe/views/device_view.dart';

class DeviceListView extends StatefulWidget {
  const DeviceListView({super.key});

  @override
  State<DeviceListView> createState() => _DeviceListViewState();
}

class _DeviceListViewState extends State<DeviceListView> {
  @override
  Widget build(BuildContext context) {
    Provider.of<DeviceViewModel>(context, listen: false).getDevices();
    return Consumer<DeviceViewModel>(
      builder: (context, deviceViewModel, child) {
        return deviceViewModel.devices.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.count(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          physics: const BouncingScrollPhysics(),
          children: deviceViewModel.devices.values.map((device) => DeviceView(device)).toList()
        );
      }
    );
  }
}