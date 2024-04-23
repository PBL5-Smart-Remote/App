import 'package:smart_home_fe/api/esp_api.dart';
import 'package:smart_home_fe/models/esp_model.dart';

class ESPService {
  final espAPI = ESPAPI();

  Future<List<ESPModel>> getESPs() async {
    try {
      return await espAPI.getESPs();
    } catch (err) {
      print('[ESPService][GetESP]: $err');
      return List.empty();
    }
  }
}