import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/utils/show_snackbar.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/view_models/connection_view_model.dart';
import 'package:smart_home_fe/views/accesspoint_view.dart';
import 'package:smart_home_fe/views/appbar_title.dart';

class ConnectionPage extends GenericPage{
  ConnectionPage({super.key}) {
    name = const Text("Connection");
    icon = const Icon(Icons.search);
    selectedColor = Colors.orange;
  }

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Searching devices"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.perm_scan_wifi),
                  label: const Text('SCAN'),
                  onPressed: () async { 
                    await Provider.of<ConnectionViewModel>(context, listen: false).scanWifi(context);
                    // scrollToTop();
                  },
                ),
              ]
            ),
            const Divider(),
            Consumer<ConnectionViewModel>(
              builder: (context, connectionViewModel, child) => Flexible(
                child: Center(
                  child: connectionViewModel.accessPoints.isEmpty
                    ? const Text("NO SCANNED RESULTS")
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: connectionViewModel.accessPoints.length,
                        itemBuilder: (context, i) => AccessPointView(accessPoint: connectionViewModel.accessPoints[i])
                      ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}   