// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:math' as math;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_fe/config/api_config.dart';
import 'package:smart_home_fe/models/user_model.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/services/user_service.dart';
import 'package:smart_home_fe/utils/business/show_snackbar.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';

class AccountPage extends GenericPage {
  AccountPage({super.key}) {
    name = const Text("Account");
    icon = const Icon(Icons.person);
    selectedColor = Colors.teal;
  }

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _serverAppController = TextEditingController(text: APIConfig.baseServerAppURL);
  final _serverFirmwareController = TextEditingController(text: APIConfig.baseServerFirmwareURL);
  final _serverAIController = TextEditingController(text: APIConfig.baseServerAIURL);

  // UserModel user;

  @override
  void initState() {
    super.initState();
    // user = UserService().getUserInfo()
  }

  Future<void> _logout (BuildContext context) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Account"),
        actions: [IconButton(onPressed: () async => _logout(context), icon: const Icon(Icons.logout))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(                
                    height: math.max(screenHeight, screenWidth) / 10,
                    width: math.max(screenHeight, screenWidth) / 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/user_avatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 100),
                  const Column(
                    children: [
                      Text('Rooms', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('12', style: TextStyle(fontSize: 16))
                    ]
                  ),
                  const SizedBox(width: 30),
                  const Column(
                    children: [
                      Text('Devices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('15', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],  
              ),
              const SizedBox(height: 10),
              const Text('HuyyCP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.blue,
                         foregroundColor: Colors.white,
                         minimumSize: const Size(double.infinity, 35)
                      ),
                      onPressed: () async {
                        // await Navigator.pushNamed(context, '/user-info');
                      }, 
                      child: const Text('Edit information')
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.blue,
                         foregroundColor: Colors.white,
                         minimumSize: const Size(double.infinity, 35)
                      ),
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/change-password');
                      }, 
                      child: const Text('Change password')
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              TextField(
                controller: _serverAIController,
                decoration: const InputDecoration(
                  label: Text('ServerAIURL')
                )
              ),
              ElevatedButton(
                onPressed: () {
                  APIConfig.baseServerAIURL = _serverAIController.text;
                  showSnackBar(context, "Success", "Update URL success", ContentType.success);
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: const Text('Update url')
              ),
              TextField(
                controller: _serverFirmwareController,
                decoration: const InputDecoration(
                  label: Text('ServerFirmwareURL')
                )
              ),
              ElevatedButton(
                onPressed: () {
                  APIConfig.baseServerFirmwareURL = _serverFirmwareController.text;
                  showSnackBar(context, "Success", "Update URL success", ContentType.success);
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: const Text('Update url')
              ),
              TextField(
                controller: _serverAppController,
                decoration: const InputDecoration(
                  label: Text('ServerAppURL')
                )
              ),
              ElevatedButton(
                onPressed: () {
                  APIConfig.baseServerAppURL = _serverAppController.text;
                  showSnackBar(context, "Success", "Update URL success", ContentType.success);
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: const Text('Update url')
              ),
            ],
          )
        ),
      )
    );
  }
}