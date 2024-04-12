// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_iot_wifi/flutter_iot_wifi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'package:smart_home_fe/api/connection_api.dart';
import 'package:smart_home_fe/models/connection_model.dart';
import 'package:smart_home_fe/view_models/connection_view_model.dart';
import 'package:wifi_scan/wifi_scan.dart';
import '../utils/show_snackbar.dart';
import '../utils/validators.dart';

class AccessPointView extends StatefulWidget {
  final WiFiAccessPoint accessPoint;
  const AccessPointView({super.key, required this.accessPoint});

  @override
  State<AccessPointView> createState() => _AccessPointViewState();
}

class _AccessPointViewState extends State<AccessPointView> {

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
                ShowHidePasswordTextField(
                  controller: _firmwarePasswordController,
                  iconSize: 20,
                  visibleOffIcon: FontAwesomeIcons.eyeSlash,
                  visibleOnIcon: FontAwesomeIcons.eye,
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
                          
                          Navigator.pop(context);
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
                                    ShowHidePasswordTextField(
                                      controller: _serverPasswordController,
                                      iconSize: 20,
                                      visibleOffIcon: FontAwesomeIcons.eyeSlash,
                                      visibleOnIcon: FontAwesomeIcons.eye,
                                      decoration: const InputDecoration(
                                        labelText: "Password",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        String ssid = _serverSSIDController.text;
                                        String password = _serverPasswordController.text;
                                        Provider.of<ConnectionViewModel>(context, listen: false).setupESP(ConnectionModel(ssid, password))
                                        // ConnectionAPI.setupESP(ConnectionModel(ssid, password))
                                        .then((success) {
                                          if (success) {
                                            kShowSnackBar(context, "Set up successfully");
                                            Navigator.pop(context);
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