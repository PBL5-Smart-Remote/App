import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/device_label_model.dart';
import 'package:smart_home_fe/models/device_model.dart';
import 'package:smart_home_fe/models/device_update_model.dart';
import 'package:smart_home_fe/utils/business/show_alert_dialog.dart';
import 'package:smart_home_fe/utils/business/show_snackbar.dart';
import 'package:smart_home_fe/utils/business/validators.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';
import 'package:smart_home_fe/views/device_view.dart';

class EditDevicePage extends StatefulWidget {
  const EditDevicePage({super.key});
  
  @override
  State<EditDevicePage> createState() => _EditDevicePageState();
}

class _EditDevicePageState extends State<EditDevicePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<DeviceLabelModel> deviceLabels = List.empty();
  DeviceModel? device;

  final _nameController = TextEditingController();
  String? _selectedLabel;  

  // @override
  // void initState() {
  //   super.initState();
  //   final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  //   setState(() {
  //     Provider.of<DeviceViewModel>(context, listen: false).getDeviceInfo(args['id']).then((value) => device = value!); 
  //     Provider.of<DeviceViewModel>(context, listen: false).getDeviceLabels(device!.type).then((value) => deviceLabels = value);
  //     _nameController.text = device!.deviceName;
  //     _selectedLabel = device!.label.idLabel;
  //   });
  // }

  Future<void> _updateDeviceInfo() async {
    if (_formKey.currentState!.validate()) {
      device!.deviceName = _nameController.text;
      Provider.of<DeviceViewModel>(context, listen: false).updateDeviceInfo(device!)
      .then((value) {
        if (value) {
          Navigator.pop(context);
          showSnackBar(context, 'Success', 'Update device successfully', ContentType.success);
        } else {
          showSnackBar(context, 'Whoops', 'Update device failed', ContentType.failure);
        }       
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (device == null || deviceLabels.isEmpty) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      Provider.of<DeviceViewModel>(context, listen: false).getDeviceInfo(args['id'])
      .then((value) { 
        device = value;
        _nameController.text = device!.deviceName;
        _selectedLabel = device!.label.idLabel;
        Provider.of<DeviceViewModel>(context, listen: false).getDeviceLabels(device!.type)
        .then((value) {
          deviceLabels = value;
          setState(() {});
        });
      }); 
    }
    
    return PopScope(
      // onPopInvoked: (didPop) => Provider.of<DeviceViewModel>(context, listen: false).clearData(),
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle('Edit device'),
        ),
        body : (deviceLabels.isEmpty || device == null) 
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateEmpty,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        label: Text('Device name')
                      ),
                    ),
                    DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateSelectionItem,
                      decoration: const InputDecoration(
                        label: Text("Device label")
                      ),
                      value: device!.label.idLabel,
                      items: List.from(deviceLabels.map(
                        (label) => DropdownMenuItem(
                          value: label.idLabel,
                          child: Text(label.labelName)
                        ))), 
                      onChanged: (value) {
                        // setState(() {
                          device!.label.idLabel = value as String;
                        // });
                        print(_selectedLabel);
                      }
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: device!.type,
                      decoration: const InputDecoration(
                        label: Text('Type')
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: device!.roomName,
                      decoration: const InputDecoration(
                        label: Text('Room')
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 35)
                      ),
                      onPressed: () async => await _updateDeviceInfo(), 
                      child: const Text('Update'),
                    )
                  ], 
                ),
              )
            )
      )
    );
  }
}