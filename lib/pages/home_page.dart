import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/views/appbar_title.dart';
import 'package:smart_home_fe/views/esp_list_view.dart';
import 'package:smart_home_fe/views/figure_icon_view.dart';
import 'package:smart_home_fe/views/room_list_view.dart';

class HomePage extends GenericPage {
  HomePage({super.key}) {
    name = const Text("Home");
    icon = const Icon(Icons.home);
    selectedColor = Colors.purple;
  }
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _tabNames = [
    'Rooms', 
    'Devices'
  ];

  final List<Widget> _tabViews = [
    const RoomListView(),
    const ESPListView(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Home"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromRGBO(244, 247, 255, 1), Color.fromRGBO(229, 236, 248, 1)])
        ),
        child: Column(
          children: [
            Container(
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
            ), // Figure bar
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromRGBO(222, 226, 231, 1),
              ),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicator: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: _tabNames.map((name) => Tab(text: name)).toList()
              )
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                dragStartBehavior: DragStartBehavior.down,
                physics: const BouncingScrollPhysics(),
                children: _tabViews,
              ),
            ),
          ],
        )
      )
    );
  }
}