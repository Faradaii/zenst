import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final int userIdLogged;
  const NotificationPage({super.key, required this.userIdLogged});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}