import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;

class SoundRecorder {
  final AudioRecorder _recorder = AudioRecorder();

  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }

  Stream<RecordState> onStateChanged() {
    return _recorder.onStateChanged();
  }

  Future<bool> start({AudioEncoder encoder = AudioEncoder.wav}) async {
    if (await _recorder.hasPermission()) {
      if (await _recorder.isEncoderSupported(encoder)) {
        final path = await _getPath();
        final config = RecordConfig(encoder: encoder, numChannels: 1);
        await _recorder.start(config, path: path);
        return true;
      }
    }
    return false;
  }

  Future<String> _getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return path.join( dir.path, 'audio.wav');
  }

  Future<String?> stop() async {
    return await _recorder.stop();
  }
}