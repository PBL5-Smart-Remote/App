import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/device_update_model.dart';
import 'package:smart_home_fe/utils/business/show_alert_dialog.dart';
import 'package:smart_home_fe/utils/business/validators.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';

class EditDevicePage extends StatefulWidget {
  const EditDevicePage({super.key});

  @override
  State<EditDevicePage> createState() => _EditDevicePageState();
}

class _EditDevicePageState extends State<EditDevicePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  String? _selectedType;
  String? _selectedRoomId;
  

  Future<void> _updateDeviceInfo(String id) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      Provider.of<DeviceViewModel>(context, listen: false).updateDeviceInfo(DeviceUpdateModel(id, name, _selectedType!, _selectedRoomId!))
      .then((value) {
        if (value) {
          showAlertDialog(context, 'Update successfully');
        } else {
          showAlertDialog(context,  'Update failed');
        }       
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Provider.of<DeviceViewModel>(context, listen: false).getDeviceInfo(args['id']);
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle('Edit device'),
      ),
      body : SingleChildScrollView(
        child: Consumer<DeviceViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.deviceTypes.isEmpty || viewModel.roomsInfo.isEmpty || viewModel.device == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              _selectedType = viewModel.device!.type == '' ? null : viewModel.device!.type;
              _selectedRoomId = viewModel.device!.idRoom == '' ? null : viewModel.device!.idRoom;
              return  Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateEmpty,
                        controller: _nameController,
                        initialValue: viewModel.device!.deviceName,
                        decoration: const InputDecoration(
                          label: Text('Device name')
                        ),
                      ),
                      DropdownButtonFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateSelectionItem,
                        decoration: const InputDecoration(
                          label: Text("Device type")
                        ),
                        value: _selectedType,
                        items: List.from(viewModel.deviceTypes.map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type)
                          ))), 
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value as String?;
                          });
                        }
                      ),
                      DropdownButtonFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateSelectionItem,
                        decoration: const InputDecoration(
                          label: Text("Room")
                        ),
                        value: _selectedRoomId,
                        items: List.from(viewModel.roomsInfo.map(
                          (room) => DropdownMenuItem(
                            value: room.$1,
                            child: Text(room.$2)
                          ))), 
                        onChanged: (value) {
                          setState(() {
                            _selectedRoomId = value as String?;
                          });
                        }
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 35)
                        ),
                        onPressed: () async => await _updateDeviceInfo(args['id']), 
                        child: const Text('Update'),
                      )
                    ], 
                  ),
                )
              );
            }
          }
        ),
      )
    );
  }
}