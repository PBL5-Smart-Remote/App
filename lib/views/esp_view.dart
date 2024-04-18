import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:smart_home_fe/models/esp_model.dart';
import 'package:smart_home_fe/views/device_view.dart';

class ESPView extends StatefulWidget {
  ESPModel espModel;
  ESPView(this.espModel, {super.key});

  @override
  State<ESPView> createState() => _ESPViewState();
}

class _ESPViewState extends State<ESPView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: const GradientBoxBorder(
        //   gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
        // ),
        // borderRadius: BorderRadius.circular(10)
      ),
      child: GridView.count(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          physics: const BouncingScrollPhysics(),
          children: widget.espModel.devices.map((device) => DeviceView(device)).toList()
        )
    );
  }
}