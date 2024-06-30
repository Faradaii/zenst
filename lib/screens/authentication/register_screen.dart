import 'package:flutter/material.dart';
import 'package:Zenst/models/user.dart';
import 'package:Zenst/screens/authentication/login_screen.dart';
import 'package:Zenst/screens/authentication/registerForm.dart';

class RegisterPage extends StatefulWidget {
  final Function(int) setIsLogged;
  final User? user;
  final bool? isGetStarted;
  const RegisterPage(
      {super.key, this.user, required this.setIsLogged, this.isGetStarted});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isGetStarted = true;

  @override
  void initState() {
    isGetStarted = widget.isGetStarted ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isGetStarted
        ? RegisterForm(
            setIsLogged: widget.setIsLogged,
          )
        : started(context);
  }

  Widget started(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/download.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0)
                ],
                begin: Alignment.topCenter,
                end: Alignment(0.1, 0.5),
              )),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Discover \nEndless Setup \nPossibilities!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Poppins',
                            height: 1.1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Unlock creativity with Setup Inspiration, one-stop guide to finding inspiration and bringing your dreams to life.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            fontFamily: 'Poppins'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isGetStarted = !isGetStarted;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            backgroundColor: Colors.lightBlue[300]),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Already have an account? ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  height: 1.2),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage(
                                              setIsLogged: widget.setIsLogged,
                                            )));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.all(0),
                                visualDensity: VisualDensity.compact,
                                elevation: 0,
                              ),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.lightBlue[300],
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ])),
          ],
        ),
      ),
    );
  }
}
