import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:record/record.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/services/voice_service.dart';
import 'package:smart_home_fe/utils/business/format_number.dart';
import 'package:smart_home_fe/utils/business/sound_recorder.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';
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
  late final SoundRecorder _soundRecoder;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  bool _isRecording = false;
  int _recordDuration = 0;
  Timer? _timer;
  String? voicePath;
  String label = "";

  @override
  void initState() {
    _soundRecoder = SoundRecorder();

    _recordSub = _soundRecoder.onStateChanged().listen((recordState) {
      _updateRecordState(recordState);
    });

    super.initState();
  }


  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      await _soundRecoder.start();
      bool isRecording = await _soundRecoder.isRecording();
      setState(() {
        _isRecording = isRecording;
        _recordDuration = 0;
        label = '';
      });
      if (_isRecording) _startTimer();
    } catch (e) {
        print(e);
    }
  }

   void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel(); 
    voicePath = await _soundRecoder.stop();
    
    print(voicePath);

  }

  
  Future<String> _sendVoice() async {
    return await voiceService.sendVoice(voicePath!);
  }

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
                if (_recordState == RecordState.stop && voicePath != null) IconButton(
                  onPressed: () async {
                    label = await _sendVoice();
                    setState(() {});
                  }, 
                  icon: const Icon(Icons.send)
                ),
                const SizedBox(width: 10),
                _buildText()
              ],
            ),
            if (_recordState == RecordState.stop) Text(label),
          ],
        ),
      )
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_recordState != RecordState.stop) {
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
             (_recordState != RecordState.stop) ? _stopRecording() : _startRecording();
          },
        ),
      ),
    );
  }

  void _updateRecordState(RecordState recordState) {
    setState(() => _recordState = recordState);

    switch (recordState) {
      case RecordState.pause:
        _timer?.cancel();
        break;
      case RecordState.record:
        _startTimer();
        break;
      case RecordState.stop:
        _timer?.cancel();
        _recordDuration = 0;
        break;
    }
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }

    return const Text("Waiting to record");
  }

  Widget _buildTimer() {
    final String minutes = formatNumber(_recordDuration ~/ 60);
    final String seconds = formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }


}