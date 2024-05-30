import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/models/device_update_model.dart';
import 'package:smart_home_fe/utils/business/show_alert_dialog.dart';
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

  final _nameController = TextEditingController();
  String? _selectedLabel;  

  Future<void> _updateDeviceInfo(String id) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      Provider.of<DeviceViewModel>(context, listen: false).updateDeviceInfo(DeviceUpdateModel(id, name, _selectedLabel!))
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
    // Provider.of<DeviceViewModel>(context, listen: true).getDeviceLabels(args['type']);
    // Provider.of<DeviceViewModel>(context, listen: true).getDeviceInfo(args['id']);
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Edit device'),
      ),
      body : FutureProvider(
       create: (context) async {
          final viewModel = Provider.of<DeviceViewModel>(context, listen: false);
          await Future.wait([
            viewModel.getDeviceLabels(args['type']),
            viewModel.getDeviceInfo(args['id']),
          ]);
          return viewModel;
        },
        initialData: Provider.of<DeviceViewModel>(context, listen: false),
        // builder: (context, child) {
        //   return Consumer<DeviceViewModel>(builder: (context, viewModel, child) {
        //     print('start build');
        //     if (viewModel.deviceLabels.isEmpty || viewModel.device == null) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else {
        //       print('rebuild');
        //       _selectedLabel = viewModel.device!.label.idLabel == '' ? null : viewModel.device!.label.idLabel;
        //       return  SingleChildScrollView(
        //         child: Padding(
        //           padding: const EdgeInsets.all(20),
        //           child: Form(
        //             key: _formKey,
        //             child: Column(
        //               children: [
        //                 TextFormField(
        //                   autovalidateMode: AutovalidateMode.onUserInteraction,
        //                   validator: validateEmpty,
        //                   controller: _nameController,
        //                   initialValue: viewModel.device!.deviceName,
        //                   decoration: const InputDecoration(
        //                     label: Text('Device name')
        //                   ),
        //                 ),
        //                 DropdownButtonFormField(
        //                   autovalidateMode: AutovalidateMode.onUserInteraction,
        //                   validator: validateSelectionItem,
        //                   decoration: const InputDecoration(
        //                     label: Text("Device label")
        //                   ),
        //                   value: _selectedLabel,
        //                   items: List.from(viewModel.deviceLabels.map(
        //                     (label) => DropdownMenuItem(
        //                       value: label.idLabel,
        //                       child: Text(label.labelName)
        //                     ))), 
        //                   onChanged: (value) {
        //                     setState(() {
        //                       _selectedLabel = value as String?;
        //                     });
        //                   }
        //                 ),
        //                 TextFormField(
        //                   readOnly: true,
        //                   initialValue: viewModel.device!.type,
        //                   decoration: const InputDecoration(
        //                     label: Text('Type')
        //                   ),
        //                 ),
        //                 TextFormField(
        //                   readOnly: true,
        //                   initialValue: viewModel.device!.roomName,
        //                   decoration: const InputDecoration(
        //                     label: Text('Room')
        //                   ),
        //                 ),
        //                 ElevatedButton(
        //                   style: ElevatedButton.styleFrom(
        //                       backgroundColor: Colors.blue,
        //                       foregroundColor: Colors.white,
        //                       minimumSize: const Size(double.infinity, 35)
        //                   ),
        //                   onPressed: () async => await _updateDeviceInfo(args['id']), 
        //                   child: const Text('Update'),
        //                 )
        //               ], 
        //             ),
        //           )
        //         ),
        //       );
        //     }
        //   });
        // },
        child: Consumer<DeviceViewModel>(
          builder: (context, viewModel, child) {
            print('start build');
            if (viewModel.deviceLabels.isEmpty || viewModel.device == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              print('rebuild');
              _selectedLabel = viewModel.device!.label.idLabel == '' ? null : viewModel.device!.label.idLabel;
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
                          label: Text("Device label")
                        ),
                        value: _selectedLabel,
                        items: List.from(viewModel.deviceLabels.map(
                          (label) => DropdownMenuItem(
                            value: label.idLabel,
                            child: Text(label.labelName)
                          ))), 
                        onChanged: (value) {
                          setState(() {
                            _selectedLabel = value as String?;
                          });
                        }
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: viewModel.device!.type,
                        decoration: const InputDecoration(
                          label: Text('Type')
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: viewModel.device!.roomName,
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