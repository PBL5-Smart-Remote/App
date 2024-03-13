import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/view_models/esp_list_view_model.dart';
import 'package:smart_home_fe/views/device_view.dart';
import 'package:smart_home_fe/views/esp_view.dart';

class ESPListView extends StatefulWidget {
  const ESPListView({super.key});

  @override
  State<ESPListView> createState() => _ESPListViewState();
}

class _ESPListViewState extends State<ESPListView> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ESPListViewModel>(context, listen:false).getESPs();
    return Container(
      child: Consumer<ESPListViewModel>(
        builder:(context, espViewModel, child) {
          return espViewModel.esps.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.count(
            mainAxisSpacing: 10,
            crossAxisCount: 1,
            physics: const BouncingScrollPhysics(),
            children: List.from(espViewModel.esps.map((esp) => ESPView(esp))),
          );
        },
        // child: GridView.count(
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 15,
        //     crossAxisCount: 2,
        //     physics: const BouncingScrollPhysics(),
        //     children: [
        //       DeviceView(DeviceModel("Light 1", "Living room", "Light")),
        //       DeviceView(DeviceModel("Light 2", "Living room", "Light")),
        //       DeviceView(DeviceModel("Fan 1", "Living room", "Fan")),
        //       DeviceView(DeviceModel("Fan 2", "Living room", "Fan")),
        //       DeviceView(DeviceModel("Door 1", "Living room", "Door")),
        //       DeviceView(DeviceModel("Door 2", "Living room", "Door")),
        //     ],
        //   ),
      )
    );
  }
}