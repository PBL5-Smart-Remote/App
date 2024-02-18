import 'package:flutter/material.dart';

class RoomCard extends StatefulWidget {
  late String imageLink;
  late String roomName;
  late int numDevices;
  late int numConnected;
  RoomCard(this.imageLink, this.roomName, this.numDevices, this.numConnected, {super.key});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(width: 2, color: Colors.white),
    
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              image: DecorationImage(image : NetworkImage(widget.imageLink), fit: BoxFit.fitHeight)
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(left: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.roomName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                Text("${widget.numDevices} devices, ${widget.numConnected} connected", style: TextStyle(color: Colors.grey[600]))
              ],
            ),
          )
        ],
      ),
    );
  }
}