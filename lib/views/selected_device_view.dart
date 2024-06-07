import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/device_model.dart';

class SelectedDeviceView extends StatefulWidget {
  DeviceModel device;
  bool isSelected = false;
  SelectedDeviceView(this.device, {super.key});

  @override
  State<SelectedDeviceView> createState() => _SelectedDeviceViewState();
}

class _SelectedDeviceViewState extends State<SelectedDeviceView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 5),    
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected ? Colors.green : Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.device.icon,
            Text(widget.device.deviceName, style: const TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(width: 10),
            Text(widget.device.roomName, style: const TextStyle(color: Colors.white)),
          ],
        )
      ),
    );
  }
}