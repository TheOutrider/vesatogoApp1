import 'package:flutter/material.dart';
import 'package:flutter_vesatogo_assignment/tabs/accounttab.dart';
import 'package:flutter_vesatogo_assignment/tabs/hometab.dart';
import 'package:flutter_vesatogo_assignment/tabs/trackingtab.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  int _currentIndex = 0;
  BuildContext context;
  final tabs = [
    HomeTab(),
    TrackingTab(),
    AccountTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        selectedFontSize: 13,
        unselectedFontSize: 10,

        selectedIconTheme: IconThemeData(
            color: Colors.blueGrey[500],
            size: 25
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey[400],
          size: 23,
        ),
        currentIndex: _currentIndex,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            title: Text('DashBoard', style: TextStyle(color: Colors.black54),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_outlined),
            title: Text('Tracking', style: TextStyle(color: Colors.black54),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Account', style: TextStyle(color: Colors.black54),),
          ),
        ],

        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },

      ),
    );
  }
}
