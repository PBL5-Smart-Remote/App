import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/widgets/room_card.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  var link = "https://media.architecturaldigest.com/photos/62f3c04c5489dd66d1d538b9/16:9/w_2560%2Cc_limit/_Hall_St_0256_v2.jpeg";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          physics: const BouncingScrollPhysics(),
          children: [
            RoomCard(RoomBriefModel(link, "Living room", 4, 3)),
            RoomCard(RoomBriefModel(link, "Dining room", 4, 3)),
            RoomCard(RoomBriefModel(link, "Bathroom", 4, 3)),
            RoomCard(RoomBriefModel(link, "Bedroom", 4, 3)),
            RoomCard(RoomBriefModel(link, "Gaming room", 4, 3)),
          ],
        )
    );
  }
}