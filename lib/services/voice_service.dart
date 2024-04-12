import 'package:smart_home_fe/api/voice_api.dart';

class VoiceService {
  final voiceAPI = VoiceAPI();

  Future<String> sendVoice(String voicePath) async {
    try {
      return await voiceAPI.sendVoice(voicePath);
    } catch (err) {
      print('[VoiceService][SendVoice]: $err');
      return "";
    }
  }
}