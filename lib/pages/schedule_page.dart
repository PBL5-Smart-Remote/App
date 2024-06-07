import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';
import 'package:smart_home_fe/view_models/schedule_view_model.dart';
import 'package:smart_home_fe/views/schedule_list_view.dart';

class SchedulePage extends GenericPage {
  SchedulePage({super.key})  {
    name = const Text("Schedule");
    icon = const Icon(Icons.calendar_month);
    selectedColor = Colors.cyan;
  }

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Future<void> addNewSchedule() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Schedule'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromRGBO(244, 247, 255, 1), Color.fromRGBO(229, 236, 248, 1)])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-schedule')
                    .then((value) => Provider.of<ScheduleViewModel>(context, listen: false).getAllSchedules());
                  }, 
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: null,
                  icon: const Icon(Icons.menu),
                ),
              ],
            ),
            Expanded(
              child: ScheduleListView(),
            )
          ],
        ),
      )
    );
  }
}