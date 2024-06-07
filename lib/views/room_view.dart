import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/pages/room_page.dart';
import 'package:smart_home_fe/view_models/room_view_model.dart';

class RoomView extends StatefulWidget {
  late RoomBriefModel room;
  RoomView(this.room, {super.key});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
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
                image: DecorationImage(image : NetworkImage(widget.room.roomImage), fit: BoxFit.fitHeight)
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(left: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.room.roomName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Text("${widget.room.numDevices} devices, ${widget.room.numConnected} connected", style: TextStyle(color: Colors.grey[600]))
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context, 
          '/room',
          arguments: {
            'id': widget.room.roomID
          }
        ).then((value) => Provider.of<RoomViewModel>(context, listen: false).clearData());
      },
    );
  }
}