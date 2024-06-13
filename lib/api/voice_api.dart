// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:smart_home_fe/config/api_config.dart';

class VoiceAPI {
  final String _sendVoiceAPI = '/audio/';

  final dio = Dio();

  Future<String> sendVoice(String voicePath) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');

      final file = await MultipartFile.fromFile(voicePath, filename: 'audio.wav');

      final formData = FormData.fromMap({
        'audio': file,
        'idRoom': '65dc45b34c0e55a017e5dd78'

      });

      final response = await dio.post(
        Uri.https(APIConfig.baseServerAIURL, _sendVoiceAPI).toString(), 
        // options: Options(
        //   headers: {
        //     "Authorization": token!
        //   }
        // ),
        data: formData 
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return data['label'] ?? 'Cannot recognize';
      } else {
        return "Cannot recognize";
      }
    } catch (err) {
      print('[VoiceAPI][SendVoice]: $err');
      return "Cannot recognize";
    }
  }
}