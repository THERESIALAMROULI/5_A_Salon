import 'package:flutter/material.dart';
import 'package:tubesfix/View/home_view.dart';
import 'package:tubesfix/View/view_list.dart';
import 'package:tubesfix/View/profile.dart';
import 'package:tubesfix/View/transaction.dart';

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
      ViewListScreen(), 
      transactionView(data: widget.data), 
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: Color(0xFFE0AC53), 
            thickness: 1.5, 
            height: 1.0,
          ),
          BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Color(0xFFE0AC53),
            unselectedItemColor: const Color(0xFFE0AC53),
            showSelectedLabels: false, 
            showUnselectedLabels: false,
            items: [
              _buildNavBarItem(icon: Icons.home, label: 'Home', index: 0),
              _buildNavBarItem(icon: Icons.list, label: 'List', index: 1),
              _buildNavBarItem(icon: Icons.person, label: 'Profile', index: 2),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: 40,
              height: 3,
              color: _selectedIndex == index ? Color(0xFFE0AC53) : Colors.transparent,
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}

