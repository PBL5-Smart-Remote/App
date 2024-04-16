import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Account"),
      ),
      body: Padding(
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
                SizedBox(width: 120),
                Column(
                  children: [
                    Text('Rooms'),
                    Text('12')
                  ]
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text('Devices'),
                    Text('15'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('HuyyCP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.blue,
                 foregroundColor: Colors.white,
                 minimumSize: Size(double.infinity, 35)
              ),
              onPressed: () {}, 
              child: Text('Edit user information')
            )
          ],
        )
      
      )
    );
  }
}