import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smart_home_fe/config/api_config.dart';


class VoiceAPI {
  final String _sendVoiceAPI = '';

  Future<bool> sendVoice(String voicePath) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      final voiceFile = File(voicePath);
      final response = await http.post(
        Uri.http(APIConfig.baseServerAppURL, _sendVoiceAPI),
        headers: {
          // "Authorization": token!,
          "Content-Type" : "audio/wav"
        },
        body: {
          "audio": voiceFile
        }
      );
      print(response.body);
      return response.statusCode == 200;
    } catch (err) {
      print('[VoiceAPI][SendVoice]: $err');
      return false;
    }
  }
}