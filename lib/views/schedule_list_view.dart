import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/schedule_model.dart';
import 'package:smart_home_fe/view_models/schedule_view_model.dart';
import 'package:smart_home_fe/views/schedule_view.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({super.key});

  @override
  State<ScheduleListView> createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ScheduleViewModel>(context, listen: false).getAllSchedules();
    return Consumer<ScheduleViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.schedules.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: List.from(viewModel.schedules.map((schedule) => ScheduleView(schedule))),
          ); 
        }
      },
    );
  }
}