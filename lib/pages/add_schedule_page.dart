// ignore_for_file: avoid_print

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/add_schedule_model.dart';
import 'package:smart_home_fe/utils/business/show_snackbar.dart';
import 'package:smart_home_fe/utils/business/validators.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';
import 'package:smart_home_fe/view_models/schedule_view_model.dart';
import 'package:smart_home_fe/views/selected_device_view.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  List<DayInWeek> days = [
    DayInWeek("Sun", dayKey: '0'),
    DayInWeek("Mon", dayKey: '1'),
    DayInWeek("Tue", dayKey: '2'),
    DayInWeek("Wed", dayKey: '3'),
    DayInWeek("Thu", dayKey: '4'),
    DayInWeek("Fri", dayKey: '5'),
    DayInWeek("Sat", dayKey: '6'),
  ];

  DateTime selectedTime = DateTime(2024);

  final _scheduleNameController = TextEditingController();

  List<SelectedDeviceView> devices = List.empty(); 

  @override
  void initState() {
    super.initState();
    Provider.of<DeviceViewModel>(context, listen: false).getDevices();
    devices = Provider.of<DeviceViewModel>(context, listen: false).devices.map((device) => SelectedDeviceView(device)).toList();
  }

  void onPressed() {
    List<int> selectedDays = days.where((day) => day.isSelected == true).map((day) => int.parse(day.dayKey)).toList();
    String scheduleName = _scheduleNameController.text;
    List<String> selectedDevices = devices.where((device) => device.isSelected == true).map((device) => device.device.id).toList();
    print(selectedTime.hour);
    print(selectedTime.minute);
    print(selectedDays);
    print(scheduleName);
    print(selectedDevices);
    Provider.of<ScheduleViewModel>(context, listen: false).addNewSchedule(AddUpdateScheduleModel(
      id: null,
      name: scheduleName, 
      devices: selectedDevices, 
      hour: selectedTime.hour, 
      minute: selectedTime.minute, 
      daysOfWeek: selectedDays
    )).then((value) { 
      if (value == true) {
        Navigator.pop(context);
        showSnackBar(context, 'Success', 'Add schedule succesfully', ContentType.success);
      } else {
        showSnackBar(context, 'Whoops', 'Add schedule failed', ContentType.failure);
      }
    });
  }

  Widget _selectTime() {
    return TimePickerSpinner(
      locale: const Locale('en', ''),
      time: selectedTime,
      is24HourMode: false,
      itemHeight: 80,
      normalTextStyle: const TextStyle(
        fontSize: 24,
      ),
      highlightedTextStyle:
          const TextStyle(fontSize: 24, color: Colors.blue),
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          selectedTime = time;
        });
      },
    );
  }

  Widget _selectDay() {
    return SelectWeekDays(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      days: days,
      border: false,
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)],
          tileMode:
          TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      onSelect: (values) { // <== Callback to handle the selected days
        print(values);
      },
    );
  }

  Widget _inputScheduleName() {
    return TextFormField(
      validator: validateEmpty,
      controller: _scheduleNameController,
      decoration: const InputDecoration(
        labelText: 'Schedule name',
      ),
    );
  }

  Widget _selectDevices() {
    return devices.isEmpty 
      ? const Center(child: CircularProgressIndicator())
      : Column(
        children: devices
      );
  }

  Widget _addScheduleButton() {
    return ElevatedButton(
      onPressed: onPressed, 
      child: const Text('Add schedule'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Add schedule'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectTime(),     
              _selectDay(),
              const SizedBox(height: 20),
              _inputScheduleName(),
              const SizedBox(height: 20),
              _selectDevices(),
              const SizedBox(height: 40),
              _addScheduleButton(),
            ],
          ),
        ),
      ),
    );
  }
}