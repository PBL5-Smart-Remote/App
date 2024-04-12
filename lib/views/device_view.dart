import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';

class DeviceView extends StatefulWidget {
  DeviceModel device;
  DeviceView(this.device, {super.key});

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: widget.device.colors)    
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.device.icon,
                Icon(widget.device.isConnected ? Icons.wifi : Icons.wifi_off, color: Colors.white)
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.device.deviceName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                // Text(widget.device.roomName, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.device.status == 1 ? "On" : "Off", style: const TextStyle(color: Colors.white, fontSize: 20)),
                Consumer<DeviceViewModel>(
                  builder: (context, deviceViewModel, child) => Switch(
                    value: widget.device.status == 1,
                    trackOutlineColor: MaterialStateColor.resolveWith((states) => Colors.grey.withOpacity(0)),
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green[400],
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey[300],
                    onChanged: (value) async {
                      final newStatus = value ? 1 : 0;
                      await deviceViewModel.changeStatus(DeviceControlModel(widget.device.idESP, widget.device.id, newStatus));
                      setState(() {
                        widget.device.status = newStatus;
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}