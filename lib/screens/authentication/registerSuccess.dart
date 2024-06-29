import 'package:flutter/material.dart';
import 'package:zenst/screens/authentication/login_screen.dart';

class RegisterSuccess extends StatefulWidget {
  final Function(int) setIsLogged;
  const RegisterSuccess({super.key, required this.setIsLogged});

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(30.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                            setIsLogged: widget.setIsLogged,
                          )));
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                backgroundColor: Colors.transparent,
                overlayColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: const Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.height / 3,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/ilust-2.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Congratulations!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Your account has been successfully created. Please Sign In to continue and get your dream setup ideas. \n\n Thank you for joining us!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ]))
                ]))));
  }
}
