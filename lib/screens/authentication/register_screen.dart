import 'package:flutter/material.dart';
import 'package:zenst/databases/db_helper.dart';
import 'package:zenst/models/user.dart';
import 'package:zenst/screens/authentication/login_screen.dart';

class RegisterPage extends StatefulWidget {
  final Function(int) setIsLogged;
  final User? user;
  const RegisterPage({super.key, this.user, required this.setIsLogged});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isGetStarted = false;
  bool isAgreeTC = false;
  bool hidePassword = true;
  DatabaseHelper db = DatabaseHelper();

  TextEditingController? name;
  TextEditingController? email;
  TextEditingController? password;

  @override
  void initState() {
    final user = widget.user;
    name = TextEditingController(text: user?.name ?? '');
    email = TextEditingController(text: user?.email ?? '');
    password = TextEditingController(text: user?.password ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isGetStarted ? form(context) : started(context);
  }

  Widget form(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Create an Account',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage('assets/images/ilust-1.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: name,
                                decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.lightBlue[500]!,
                                        width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: email,
                                decoration: InputDecoration(
                                  hintText: 'myemail@example.com',
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.lightBlue[500]!,
                                        width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: password,
                                obscureText: hidePassword ? true : false,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(hidePassword
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.lightBlue[500]!,
                                        width: 2),
                                  ),
                                  hintText: '**********',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 50,
                                  child: Checkbox(
                                      value: isAgreeTC,
                                      activeColor: Colors.lightBlue[300],
                                      side: BorderSide(color: Colors.black),
                                      onChanged: (bool? value) => setState(() {
                                            isAgreeTC = value!;
                                          })),
                                ),
                                Expanded(
                                  child: RichText(
                                    softWrap: true,
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                'By signing up, you agree to our '),
                                        TextSpan(
                                            text: 'Terms & Conditions ',
                                            style: TextStyle(
                                                color: Colors.lightBlue[300])),
                                        TextSpan(text: 'and '),
                                        TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                                color: Colors.lightBlue[300])),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    upsertUser();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      backgroundColor: Colors.lightBlue[300]),
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
                            color: Colors.black,
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
                                  builder: (context) => new LoginPage(
                                        setIsLogged: widget.setIsLogged,
                                      )));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.lightBlue[300],
                            fontFamily: 'Poppins',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          padding: const EdgeInsets.all(0),
                          visualDensity: VisualDensity.compact,
                          elevation: 0,
                        ),
                      )
                    ],
                  ),
                )
              ])),
    );
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
                        'Get \nPreferences \nSetup Quickly!',
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
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            isGetStarted = !isGetStarted;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            backgroundColor: Colors.lightBlue[300]),
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
                                        builder: (context) => new LoginPage(
                                              setIsLogged: widget.setIsLogged,
                                            )));
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.lightBlue[300],
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.all(0),
                                visualDensity: VisualDensity.compact,
                                elevation: 0,
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

  Widget successRegister() {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(30.0),
          child: ElevatedButton(
            child: const Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new LoginPage(
                            setIsLogged: widget.setIsLogged,
                          )));
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                backgroundColor: Colors.transparent,
                overlayColor: Colors.transparent,
                shadowColor: Colors.transparent),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
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
                            SizedBox(
                              height: 20,
                            ),
                            Text(
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
                            SizedBox(
                              height: 20,
                            ),
                            Text(
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
                            SizedBox(
                              height: 20,
                            ),
                          ]))
                ]))));
  }

  Future<void> upsertUser() async {
    if ((name!.text != '') &&
        (email!.text != '') &&
        (password!.text != '') &&
        isAgreeTC) {
      await db.insertUser(User(
        name: name!.text,
        email: email!.text,
        password: password!.text,
      ));
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => successRegister(),
          ));
    } else {
      print(widget.user);
      print(isAgreeTC);
      print('error');
    }
  }
}
