import 'package:flutter/material.dart';
import 'package:Zenst/screens/assist/assist.dart';
import 'package:Zenst/screens/discover/discover.dart';
import 'package:Zenst/screens/notification/notification.dart';
import 'package:Zenst/screens/picks/picks.dart';
import 'package:Zenst/screens/profile/profile.dart';

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

  late final List<Widget> _widgetOptions = <Widget>[
    DiscoverPage(userIdLogged: widget.userIdLogged),
    const PicksPage(),
    const AssistPage(),
    NotificationPage(userIdLogged: widget.userIdLogged),
    ProfilePage(
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
      backgroundColor: _selectedNavbar == 0 ? Colors.black : Colors.white,
      appBar: AppBar(
        toolbarOpacity: 0.2,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: _selectedNavbar == 0 ? Colors.black : Colors.white,
                spreadRadius: _selectedNavbar == 0 ? 0 : 10,
                blurRadius: _selectedNavbar == 0 ? 0 : 10,
                offset: _selectedNavbar == 0
                    ? const Offset(0, 0)
                    : const Offset(0, -3),
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
              const SizedBox(
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
      body: IndexedStack(
        index: _selectedNavbar,
        children: _widgetOptions,
      ),
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
      onTap: _changeSelectedNavbar,
    );
  }
}
