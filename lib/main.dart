import 'package:flutter/material.dart';
import 'package:zenst/screens/authentication/register_screen.dart';
import 'package:zenst/screens/frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogged = false;
  int userIdLogged = 0;

  @override
  Widget build(BuildContext context) {
    void setIsLogged(int userId) {
      setState(() {
        isLogged = true;
        userIdLogged = userId;
      });

    }

    void setLoggedOut() {
      setState(() {
        isLogged = false;
        userIdLogged = 0;
      });
    }

    return MaterialApp(
      title: 'Zenst',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLogged
          ? MyHomePage(userIdLogged: userIdLogged, setLoggedOut: setLoggedOut)
          : RegisterPage(setIsLogged: setIsLogged, isGetStarted: false),
      debugShowCheckedModeBanner: false,
    );
  }
}
