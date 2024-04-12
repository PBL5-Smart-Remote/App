import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:smart_home_fe/config/api_config.dart';


class VoiceAPI {
  final String _sendVoiceAPI = '/audio';

  Future<String> sendVoice(String voicePath) async {
    try {
      // var prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      // final voiceFile = File(voicePath);

      var request = http.MultipartRequest('POST', Uri.https(APIConfig.baseServerAIURL, _sendVoiceAPI));

      // Add file
      var file = await http.MultipartFile.fromPath(
        'audio',
        voicePath,
        contentType: MediaType('audio', 'm4a'),
      );
      request.files.add(file);

      // Send the request
      var streamResponse = await request.send();

      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['label'];
      } else {
        return "";
      }
    } catch (err) {
      print('[VoiceAPI][SendVoice]: $err');
      return "";
    }
  }
}