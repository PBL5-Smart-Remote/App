import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/device_control_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionAPI {
  static const String _changeStatusAPI = '/esp';

  static Future<bool> changeStatus(DeviceControlModel model) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final response = await http.post(
        Uri.http(APIConfig.baseEspURL, _changeStatusAPI, { "id" : model.idESP }),
        // headers: {
        //   "Authorization": token!
        // },
        body: {
          "devices": {
            "id": model.idRelayPin,
            "action": model.action
          }
        }
      );
      return response.statusCode == 200;
    } catch (err) {
      print(err);
      return false;
    }
  }
}