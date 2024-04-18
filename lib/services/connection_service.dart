import 'package:smart_home_fe/api/connection_api.dart';
import 'package:smart_home_fe/models/connection_model.dart';

class ConnectionService {
  final connectionAPI = ConnectionAPI();

  Future<bool> setupESP(ConnectionModel connection) async {
    try {
      await connectionAPI.setupESP(connection);
      return true;
    } catch (err) {
      print("[ConnectionService][SetupESP]: $err");
      return false;
    }
  }
}