import 'package:dashed_line/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/device_brief_model.dart';

class DeviceCard extends StatefulWidget {
  DeviceBriefModel device;
  DeviceCard(this.device, {super.key});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
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
                Text(widget.device.roomName, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.device.isActive ? "On" : "Off", style: const TextStyle(color: Colors.white, fontSize: 20)),
                Switch(
                  value: widget.device.isActive,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green[400],
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[200],
                  onChanged: (value) {
                    setState(() {
                      widget.device.isActive = value;
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}