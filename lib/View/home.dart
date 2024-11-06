import 'package:flutter/material.dart';
import 'package:tubesfix/View/view_list.dart';
import 'package:tubesfix/View/profile.dart';
import 'package:tubesfix/View/home_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    homeView(),
    ListNamaView(),
<<<<<<< Updated upstream
=======
    
>>>>>>> Stashed changes
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.black, // <-- This works for fixed
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color.fromARGB(255, 228, 218, 128),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list,),label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}