import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_plugin/community_screen.dart';
import 'package:project_plugin/map_screen.dart';
import 'package:project_plugin/profile_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  late int _currentIndex = 0;
  late PageController _pageController = PageController();

  final List<String> _titles = ['커뮤니티', '지도', '프로필'];

  final List<String> _iconPaths = [
    'assets/icon/community.png',
    'assets/icon/map.png',
    'assets/icon/profile.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [CommunityScreen(), MapScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: bottomNavigationBarWidget(),
    );
  }

  BottomNavigationBar bottomNavigationBarWidget() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      iconSize: 30,
      selectedItemColor: Color(0xffFFE551),
      unselectedItemColor: Color(0xffF0F0F0),
      selectedFontSize: 14,

      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xffFFE551),
      ),
      selectedIconTheme: IconThemeData(color: Color(0xffFFE551)),
      currentIndex: _currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      items: List.generate(
        _titles.length,
        (index) => BottomNavigationBarItem(
          icon: Image.asset(
            _iconPaths[index],
            width: 35,
            height: 35,
            color:
                _currentIndex == index ? Color(0xffFFE551) : Color(0xffF0F0F0),
          ),
          label: _currentIndex == index ? _titles[index] : '',
        ),
      ),
    );
  }
}
