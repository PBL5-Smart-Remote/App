import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_fe/pages/account_page.dart';
import 'package:smart_home_fe/pages/connection_page.dart';
import 'package:smart_home_fe/pages/home_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:smart_home_fe/pages/schedule_page.dart';
import 'package:smart_home_fe/pages/voice_page.dart';
import 'package:smart_home_fe/utils/business/show_snackbar.dart';
import 'package:smart_home_fe/view_models/device_view_model.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _pages = [
    HomePage(),
    SchedulePage(),
    VoicePage(),
    ConnectionPage(),
    AccountPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.all(15),
        currentIndex: _currentPage,
        onTap: (selectedIndex) {
          _currentPage = selectedIndex;
          _pageController.animateToPage(
            selectedIndex,
            duration: const Duration(microseconds: 100),
            curve: Curves.easeInOut,
          );
        },
        items: _pages.map(
          (page) => SalomonBottomBarItem(icon: page.icon, title: page.name, selectedColor: page.selectedColor)).toList()
      ),
    );
  }
}