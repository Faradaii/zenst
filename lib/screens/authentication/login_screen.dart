import 'package:flutter/material.dart';
import 'package:zenst/Models/user.dart';
import 'package:zenst/databases/db_helper.dart';
import 'package:zenst/screens/authentication/register_screen.dart';

class LoginPage extends StatefulWidget {
  final Function(int) setIsLogged;
  final User? user;
  const LoginPage({super.key, this.user, required this.setIsLogged});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool keepSignedIn = false;
  bool hidePassword = true;
  DatabaseHelper db = DatabaseHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  TextEditingController? name;
  TextEditingController? email;
  TextEditingController? password;

  @override
  void initState() {
    final user = widget.user;
    email = TextEditingController(text: user?.email ?? '');
    password = TextEditingController(text: user?.password ?? '');
    super.initState();
  }

  Future<void> _login() async {
    final dbHelper = DatabaseHelper();
    final user = await dbHelper.getUser(email!.text, password!.text);

    print(user);
    bool isLoggedIn = user != null;

    if (isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign In Successful'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.lightBlue[400],
          showCloseIcon: true,
        ),
      );
      widget.setIsLogged(user['id']);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[400],
          showCloseIcon: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Form(
          key: _formKey,
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
                          'Welcome to Zenst!',
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
                                  image:
                                      AssetImage('assets/images/ilust-1.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
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
                                TextFormField(
                                  controller: email,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill with your email.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'myemail@example.com',
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                                TextFormField(
                                  controller: password,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill with your password.';
                                    }
                                    return null;
                                  },
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 50,
                                    child: Checkbox(
                                        value: keepSignedIn,
                                        activeColor: Colors.lightBlue[300],
                                        side: BorderSide(color: Colors.black),
                                        onChanged: (bool? value) =>
                                            setState(() {
                                              keepSignedIn = value!;
                                            })),
                                  ),
                                  Expanded(
                                    child: RichText(
                                        softWrap: true,
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Keep me signed in '),
                                            ])),
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
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
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
                                  builder: (context) => RegisterPage(
                                        setIsLogged: widget.setIsLogged,
                                      )));
                        },
                        child: Text(
                          'Sign Up',
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
}
