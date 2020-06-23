import 'package:flutter/material.dart';
import 'package:flutterstanapp/carib_funds_view.dart';
import 'package:flutterstanapp/views/test_view.dart';
import 'global_funds_view.dart';
import 'package:flutterstanapp/constants/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CaribbeanFundsView(),
    GlobalFundsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            elevation: 10,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            backgroundColor: navBarColor,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                title: Text(
                  'Caribbean Funds',
                  style: TextStyle(fontSize: 15),
                ),
                icon: new Icon(Icons.description),
              ),
              BottomNavigationBarItem(
                title: Text(
                  'Global Funds',
                  style: TextStyle(fontSize: 15),
                ),
                icon: new Icon(Icons.description),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(
      () {
        _currentIndex = index;
      },
    );
  }
}
