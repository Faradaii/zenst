import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
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
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[
                Color.fromARGB(0, 0, 0, 0),
                const Color.fromARGB(255, 0, 0, 0)
              ],
              begin: Alignment.topCenter,
              end: Alignment(0.1, 0.5),
            )),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get \nPreferences \nSetup Quickly!',
                      textAlign: TextAlign.left,
                      textWidthBasis: TextWidthBasis.parent,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 1.2),
                    ),
                    Text(
                      'lorem ipsum dolor sit amet dolor di meutn fdsa',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.2),
                    ),
                    ElevatedButton(
                      child: Text('Get Started'),
                      onPressed: () {},
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Already have an account? Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.2),
                      ),
                    )
                  ])),
        ],
      ),
    );
  }
}
