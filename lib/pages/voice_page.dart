import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/services/voice_service.dart';
import 'package:smart_home_fe/views/appbar_title.dart';
import 'package:path_provider/path_provider.dart';

class VoicePage extends GenericPage {
  VoicePage({super.key}) {
    name = const Text("Voice");
    icon = const Icon(Icons.mic);
    selectedColor = Colors.pink;
  }

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final voiceService = VoiceService();
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();
  bool _isRecording = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  Amplitude? _amplitude;
  String? voicePath;
  String label = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Voice"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRecordStopControl(),
                if (!_isRecording && voicePath != null) IconButton(
                  onPressed: () async {
                    label = await _sendVoice();
                    print(label);
                    setState(() {});
                  }, 
                  icon: const Icon(Icons.send)
                )
              ],
            ),
            Text(label),
          ],
        ),
      )
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_isRecording) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final ThemeData theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isRecording ? _stopRecording() : _startRecording();
          },
        ),
      ),
    );
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel(); 
    _ampTimer?.cancel(); 
    voicePath = await _audioRecorder.stop();
    
    print(voicePath);

    setState(() => _isRecording = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer = Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {});
    });
  }

  Future<String> _sendVoice() async {
    final directory = await getApplicationDocumentsDirectory();
    final wavFilePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.wav';

    // Copy the recorded audio file to a new WAV file
    // await File(voicePath!).copy(wavFilePath);
    print(voicePath);
    // voicePath = wavFilePath;
    // print(voicePath);

    return await voiceService.sendVoice(voicePath!);
  }
}