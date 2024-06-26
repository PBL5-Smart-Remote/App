import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/room_brief_model.dart';
import 'package:smart_home_fe/view_models/room_list_view_model.dart';
import 'package:smart_home_fe/views/room_view.dart';

class RoomListView extends StatefulWidget {
  const RoomListView({super.key});

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  var link = "https://media.architecturaldigest.com/photos/62f3c04c5489dd66d1d538b9/16:9/w_2560%2Cc_limit/_Hall_St_0256_v2.jpeg";

  @override
  Widget build(BuildContext context) {
    Provider.of<RoomListViewModel>(context, listen: false).getRooms();
    return Container(
      child: Consumer<RoomListViewModel>(
        builder: (context, roomViewModel, child) {
          return roomViewModel.rooms.isEmpty 
            ? const Center(child: CircularProgressIndicator())
            : GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 15,
              crossAxisCount: 2,
              physics: const BouncingScrollPhysics(),
              children: List.from(roomViewModel.rooms.map((room) => RoomView(room))), 
            );
        },
      )
    );
  }
}