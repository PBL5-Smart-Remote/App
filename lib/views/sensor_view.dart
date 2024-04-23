import 'package:flutter/material.dart';
import 'package:smart_home_fe/utils/widget/figure_icon_view.dart';

class SensorView extends StatefulWidget {
  const SensorView({super.key});

  @override
  State<SensorView> createState() => _SensorViewState();
}

class _SensorViewState extends State<SensorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FigureIconView(Icon(Icons.water_drop, color: Colors.blue[300]), "humidity", "75%"),
          VerticalDivider(thickness: 1, width: 1, color: Colors.grey[200]),
          FigureIconView(Icon(Icons.electric_bolt_rounded, color: Colors.blue[900]), "energy", "60kwh"),
          VerticalDivider(thickness: 1, width: 1, color: Colors.grey[200]),
          FigureIconView(Icon(Icons.thermostat_rounded, color: Colors.amber[900]), "temp", "24°C")
        ],
      )
    );
  }
}