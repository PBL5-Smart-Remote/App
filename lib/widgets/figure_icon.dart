import 'package:flutter/material.dart';

class FigureIcon extends StatefulWidget {
  late Icon icon;
  late String field;
  late String figure;
  FigureIcon(this.icon, this.field, this.figure, {super.key});

  @override
  State<FigureIcon> createState() => _FigureIconState();
}

class _FigureIconState extends State<FigureIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          widget.icon,
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.field, 
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black54
                )
              ),
              Text(
                widget.figure,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}