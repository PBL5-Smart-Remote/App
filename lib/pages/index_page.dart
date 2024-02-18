import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_fe/pages/account_page.dart';
import 'package:smart_home_fe/pages/home_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _pageController = PageController();
  int _currentPage = 0;

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
        children: [
          const HomePage(),
          Container(),
          const AccountPage(),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 1,
        style: TabStyle.fixedCircle, 
        activeColor: Colors.grey[700],
        color: Colors.grey[500],
        backgroundColor: Colors.white,
        items: [
          const TabItem(icon: Icons.home, title: "Home"),
          TabItem(
            icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle, 
                color: Colors.blue
              ), 
              width: 50, 
              height: 50, 
              child: const Icon(Icons.mic_rounded, color: Colors.white)
            )
          ),
          const TabItem(icon: Icons.person, title: "Account"),
        ],
        onTap: (index) {
          setState(() {
            _currentPage = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}