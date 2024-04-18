import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FigureIconView extends StatefulWidget {
  late Icon icon;
  late String field;
  late String figure;
  FigureIconView(this.icon, this.field, this.figure, {super.key});

  @override
  State<FigureIconView> createState() => _FigureIconViewState();
}

class _FigureIconViewState extends State<FigureIconView> {
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