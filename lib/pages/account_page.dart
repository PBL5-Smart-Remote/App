import 'package:flutter/material.dart';
import 'package:smart_home_fe/pages/generic_page.dart';
import 'package:smart_home_fe/views/appbar_title.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle("Account"),
      ),
      body: const Center(
        child: Icon(Icons.person)
      )
    );
  }
}