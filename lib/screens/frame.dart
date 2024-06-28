import 'package:flutter/material.dart';
import 'package:zenst/screens/assist/assist.dart';
import 'package:zenst/screens/discover/discover.dart';
import 'package:zenst/screens/profile/profile.dart';

class MyHomePage extends StatefulWidget {
  final Function() setLoggedOut;
  final int userIdLogged;
  const MyHomePage(
      {super.key, required this.userIdLogged, required this.setLoggedOut});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedNavbar = 0;

  late List<Widget> _widgetOptions = <Widget>[
    Discover(userIdLogged: widget.userIdLogged),
    Text(
      'Index 1: Business',
    ),
    Assist(),
    Text(
      'Index 2: School',
    ),
    Profile(
      userIdLogged: widget.userIdLogged,
      setLoggedOut: widget.setLoggedOut,
    ),
  ];

  List<String> page = [
    'Discover',
    'Picks',
    'Assist',
    'Notification',
    'Profile'
  ];

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: _selectedNavbar == 0 ? Colors.black : Colors.white,
      appBar: AppBar(
        toolbarOpacity: 0.2,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: _selectedNavbar == 0
                    ? Colors.black
                    : Colors.white, // Warna shadow dan opacity
                spreadRadius: _selectedNavbar == 0 ? 0 : 10,
                blurRadius: _selectedNavbar == 0 ? 0 : 20,
                offset: _selectedNavbar == 0
                    ? Offset(0, 0)
                    : Offset(0, -3), // Offset shadow
              ),
            ],
          ),
        ),
        title: Center(
          child: Column(
            children: [
              Text(
                page[_selectedNavbar],
                style: TextStyle(
                    color: _selectedNavbar == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: 0.1 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: _selectedNavbar == 0 ? Colors.white : Colors.black,
                      width: 2,
                    ),
                  )))
            ],
          ),
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedNavbar)),
      bottomNavigationBar: bottomNavbar(),
    );
  }

  Widget bottomNavbar() {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      useLegacyColorScheme: true,
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: ('Discover'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_rounded),
          label: ('Picks'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          label: ('Assist'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: ('Notification'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: ('Profile'),
        ),
      ],
      currentIndex: _selectedNavbar,
      selectedItemColor: Colors.lightBlue[300],
      unselectedItemColor: Colors.grey,
      // showUnselectedLabels: false,
      // showSelectedLabels: false,
      onTap: _changeSelectedNavbar,
    );
  }
}