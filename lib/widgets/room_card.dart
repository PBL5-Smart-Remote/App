import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/pages/room_devices_page.dart';

class RoomCard extends StatefulWidget {
  late RoomBriefModel room;
  RoomCard(this.room, {super.key});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                image: DecorationImage(image : NetworkImage(widget.room.imageLink), fit: BoxFit.fitHeight)
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(left: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.room.roomName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Text("${widget.room.numDevices} devices, ${widget.room.numConnected} connected", style: TextStyle(color: Colors.grey[600]))
                ],
              ),
            )
          ],
        ),
      ),
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RoomDevicesPage(widget.room.roomName);
        }));
      },
    );
  }
}