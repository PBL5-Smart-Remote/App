// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_iot_wifi/flutter_iot_wifi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_home_fe/api/connection_api.dart';
import 'package:smart_home_fe/models/connection_model.dart';
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
          title: const Text("Connect to ESP"),
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
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("SET UP ESP"),
                              content: Form(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      validator: validateEmpty,
                                      controller: _serverSSIDController,
                                      decoration: const InputDecoration(
                                        labelText: "SSID",
                                      ),
                                    ),
                                    TextFormField(
                                      validator: validateEmpty,
                                      controller: _serverPasswordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: "Password",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        String ssid = _serverSSIDController.text;
                                        String password = _serverPasswordController.text;
                                        ConnectionAPI.setupESP(ConnectionModel(ssid, password))
                                        .then((success) {
                                          if (success) {
                                            kShowSnackBar(context, "Set up successfully");
                                          } else {
                                            kShowSnackBar(context, "Set up failed");
                                          }
                                        });
                                      },
                                      child: const Text("Set up"))
                                  ],
                                ),
                              ),
                            )
                          );
                        } else {
                          kShowSnackBar(context, "Connect failed");
                        }
                      });
                    } else {
                      kShowSnackBar(context, "No permission");
                    }
                  },
                  child: const Text("Connect"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}