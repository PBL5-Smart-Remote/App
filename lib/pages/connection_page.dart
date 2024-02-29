import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_home_fe/helpers/show_snackbar.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/widgets/accesspoint_tile.dart';
import 'package:smart_home_fe/widgets/appbar_title.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

class ConnectionPage extends GenericPage{
  ConnectionPage({super.key}) {
    name = const Text("Connection");
    icon = const Icon(Icons.search);
    selectedColor = Colors.orange;
  }

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {

  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;

  @override
  void initState() {
    subscription = WiFiScan.instance.onScannedResultsAvailable.listen((result) => setState(() => accessPoints = result.where((element) => element.standard == WiFiStandards.legacy).toList()));
    super.initState();
  }

  Future<void> _startScan(BuildContext context) async {
    final can = await WiFiScan.instance.canStartScan();
    if (can != CanStartScan.yes) {
      if (mounted) kShowSnackBar(context, "Cannot start scan: $can");
      return;
    }
    // call startScan API
    await WiFiScan.instance.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Searching devices"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.perm_scan_wifi),
                      label: const Text('SCAN'),
                      onPressed: () async => _startScan(context),
                    ),
                  ]
                ),
                const Divider(),
                Flexible(
                  child: Center(
                    child: accessPoints.isEmpty
                        ? const Text("NO SCANNED RESULTS")
                        : ListView.builder(
                            itemCount: accessPoints.length,
                            itemBuilder: (context, i) => AccessPointTile(accessPoint: accessPoints[i])
                          ),
                  ),
                ),
              ],
        ),
      )
    );
  }
}   