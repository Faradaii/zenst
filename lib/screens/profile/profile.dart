import 'package:flutter/material.dart';
import 'package:zenst/databases/db_helper.dart';

class ProfilePage extends StatefulWidget {
  final Function() setLoggedOut;
  final int userIdLogged;
  const ProfilePage(
      {super.key, required this.setLoggedOut, required this.userIdLogged});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Text(widget.userIdLogged.toString()),
        ElevatedButton(
          onPressed: () {
            widget.setLoggedOut();
          },
          child: Text('Logout'),
        ),
        ElevatedButton(
          onPressed: () {
            DatabaseHelper()
                .getAllBookmarksString()
                .then((value) => print(value));
          },
          child: Text('bookmark'),
        ),
      ]),
    );
  }
}
