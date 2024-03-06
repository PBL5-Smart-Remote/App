// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_iot_wifi/flutter_iot_wifi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../helpers/show_snackbar.dart';
import '../helpers/validators.dart';

class AccessPointTile extends StatefulWidget {
  final WiFiAccessPoint accessPoint;
  const AccessPointTile({super.key, required this.accessPoint});

  @override
  State<AccessPointTile> createState() => _AccessPointTileState();
}

class _AccessPointTileState extends State<AccessPointTile> {
  final _firmwarePasswordController = TextEditingController();
  final _serverSSIDController = TextEditingController();
  final _serverPasswordController = TextEditingController();

  Future<bool> _checkPermissions() async {
    if (Platform.isIOS || await Permission.location.request().isGranted) {
      return true;
    }
    return false;
  }

  Widget _buildInfo(String label, dynamic value) => Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(value.toString()))
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final title = widget.accessPoint.ssid.isNotEmpty ? widget.accessPoint.ssid : "**EMPTY**";
    final signalIcon = widget.accessPoint.level >= -80
        ? Icons.signal_wifi_4_bar
        : Icons.signal_wifi_0_bar;
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(signalIcon),
      title: Text(title),
      subtitle: Text(widget.accessPoint.capabilities),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  readOnly: true,
                  initialValue: title,
                  decoration: const InputDecoration(
                    labelText: "SSID",
                  ),
                ),
                TextFormField(
                  validator: validateEmpty,
                  controller: _firmwarePasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await _checkPermissions()) {
                      FlutterIotWifi.connect(title, _firmwarePasswordController.text, prefix: true)
                      .then((success) {
                        if(success == true) {
                          kShowSnackBar(context, "Connect successfully");

                        } else {
                          kShowSnackBar(context, "Connect failed");
                        }
                      });
                    } else {
                      kShowSnackBar(context, "No permission");
                    }
                  },
                  child: Text("Connect"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}