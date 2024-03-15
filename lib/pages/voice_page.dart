import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/views/appbar_title.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Voice"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.mic),
          label: const Text("Say something"),
          onPressed: null,
        ),
      )
    );
  }
}