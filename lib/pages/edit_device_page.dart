import 'package:flutter/material.dart';
import 'package:smart_home_fe/views/appbar_title.dart';

class EditDevicePage extends StatefulWidget {
  const EditDevicePage({super.key});

  @override
  State<EditDevicePage> createState() => _EditDevicePageState();
}

class _EditDevicePageState extends State<EditDevicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle('Edit device'),
      ),
    );
  }
}