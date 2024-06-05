import 'package:flutter/material.dart';
import 'package:smart_home_fe/models/schedule_model.dart';

class ScheduleView extends StatefulWidget {
  ScheduleModel schedule;
  ScheduleView(this.schedule, {super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${widget.schedule.hour}:${widget.schedule.minute}', style: TextStyle(fontSize: 30)),
                // TextSpan(text: 'AM',style: TextStyle(fontSize: 16, )),
              ],
            ),
          ),
          SizedBox(width: 20),
          Row(
            children: [
              Padding(padding: const EdgeInsets.only(left: 2, right: 2), child: Text('S', style: TextStyle(color: widget.schedule.daysOfWeek.contains(1) ? Colors.white : Colors.grey[500] ))),
              Padding(padding: const EdgeInsets.only(left: 2, right: 2), child: Text('M', style: TextStyle(color: widget.schedule.daysOfWeek.contains(2) ? Colors.white : Colors.grey[500] ))),
              Padding(padding: const EdgeInsets.only(left: 2, right: 2), child: Text('T', style: TextStyle(color: widget.schedule.daysOfWeek.contains(3) ? Colors.white : Colors.grey[500] ))),
              Padding(padding: const EdgeInsets.only(left: 2, right: 2), child: Text('W', style: TextStyle(color: widget.schedule.daysOfWeek.contains(4) ? Colors.white : Colors.grey[500] ))),
              Padding(padding: const EdgeInsets.only(left: 2, right: 2), child: Text('T', style: TextStyle(color: widget.schedule.daysOfWeek.contains(5) ? Colors.white : Colors.grey[500] ))),
              Padding(padding: const EdgeInsets.only(left: 2, right: 2), child: Text('F', style: TextStyle(color: widget.schedule.daysOfWeek.contains(6) ? Colors.white : Colors.grey[500] ))),
              Padding(padding: const EdgeInsets.only(left: 2, right: 2), child: Text('S', style: TextStyle(color: widget.schedule.daysOfWeek.contains(7) ? Colors.white : Colors.grey[500] ))),
            ],
          ),
          // RichText(
          //   text: TextSpan(
          //     children: <TextSpan>[
          //       TextSpan(text: 'S', style: TextStyle(color: widget.schedule.daysOfWeek.contains(1) ? Colors.white : Colors.grey )),
          //       TextSpan(text: 'M', style: TextStyle(color: widget.schedule.daysOfWeek.contains(2) ? Colors.white : Colors.grey )),
          //       TextSpan(text: 'T', style: TextStyle(color: widget.schedule.daysOfWeek.contains(3) ? Colors.white : Colors.grey )),
          //       TextSpan(text: 'W', style: TextStyle(color: widget.schedule.daysOfWeek.contains(4) ? Colors.white : Colors.grey )),
          //       TextSpan(text: 'T', style: TextStyle(color: widget.schedule.daysOfWeek.contains(5) ? Colors.white : Colors.grey )),
          //       TextSpan(text: 'F', style: TextStyle(color: widget.schedule.daysOfWeek.contains(6) ? Colors.white : Colors.grey )),
          //       TextSpan(text: 'S', style: TextStyle(color: widget.schedule.daysOfWeek.contains(7) ? Colors.white : Colors.grey )),
          //     ],
          //   ),
          // ),
          Switch(
            value: widget.schedule.isActive,
            trackOutlineColor: MaterialStateColor.resolveWith((states) => Colors.grey.withOpacity(0)),
            activeColor: Colors.white,
            activeTrackColor: Colors.green[400],
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey[300],
            onChanged: (value) async {
              setState(() {
                widget.schedule.isActive = value;
              });
            },
          ),
        ],
      ),
    );
  }
}