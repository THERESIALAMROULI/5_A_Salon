import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:tubesfix/View/home_view.dart';
import 'package:tubesfix/View/view_list.dart';
import 'package:tubesfix/View/profile.dart';

class HomeView extends StatefulWidget {
  final Map? data;

  const HomeView({super.key, this.data});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      homeView(data: widget.data),
      ViewListScreen(data: widget.data),
      profileView(),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        color: const Color(0xFFE0AC53), 
        activeColor: const Color(0xFFE0AC53),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.list, title: 'List'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
        style: TabStyle.reactCircle, 
      ),
    );
  }
}