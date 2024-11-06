import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:guidedlayout2_2160/View/view_list.dart';
import 'package:guidedlayout2_2160/View/profile.dart';
=======
import 'package:tubesfix/View/transaction.dart';
import 'package:tubesfix/View/view_list.dart';
import 'package:tubesfix/View/profile.dart';
import 'package:tubesfix/View/home_view.dart';
import 'package:tubesfix/View/view_list.dart';
>>>>>>> Stashed changes

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

    Center(
      child: Image(image: NetworkImage('https://picsum.photos/200/300'))
      ),

    ListNamaView(),
<<<<<<< Updated upstream

    ProfileScreen(),
=======
    profileView(),
    transactionView(),
>>>>>>> Stashed changes
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list,),label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'Transaction'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}