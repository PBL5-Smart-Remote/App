// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/api/connection_api.dart';
import 'package:smart_home_fe/models/connection_model.dart';
import 'package:smart_home_fe/services/connection_service.dart';
import 'package:smart_home_fe/utils/show_snackbar.dart';
import 'package:wifi_scan/wifi_scan.dart';

class ConnectionViewModel with ChangeNotifier {
  late ConnectionService _connectionService;
  late List<WiFiAccessPoint> _accessPoints;
  StreamSubscription<List<WiFiAccessPoint>>? subscription;

  List<WiFiAccessPoint> get accessPoints => _accessPoints;

  ConnectionViewModel() {
    _connectionService = ConnectionService();
    _accessPoints = [];
    subscription = WiFiScan.instance.onScannedResultsAvailable
                    .listen((result) { 
                      _accessPoints = result.toList();
                    }); 
  }

  Future<void> scanWifi(BuildContext context) async {
    try {
      final can = await WiFiScan.instance.canStartScan();
      if (can == CanStartScan.yes) {
        await WiFiScan.instance.startScan();
        notifyListeners();
      } else {
        kShowSnackBar(context, '$can');
      }
    } catch (err) {
      print('[ConnectionViewModel][ScanWifi]: $err');
    }
  }

  Future<bool> setupESP(ConnectionModel connection) async {
    try {
      await _connectionService.setupESP(connection);
      return true;
    } catch (err) {
      print('[ConnectionViewModel][SetupESP]: $err');
      return false;
    }
  }
}