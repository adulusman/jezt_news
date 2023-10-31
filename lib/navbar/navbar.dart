import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:jezt_news/constants/constats.dart';
import 'package:jezt_news/navbar/home.dart';
import 'package:jezt_news/navbar/news_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [const HomePage(), const NewsPage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    scrHeight = size.height;
    scrWidth = size.width;
    return Scaffold(
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Image.asset(
              Constants.homeIcon,
              width: 30,
            ),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Image.asset(
              Constants.newspaper,
              width: 30,
            ),
            title: const Text('News'),
          ),
        ],
      ),
    );
  }
}
