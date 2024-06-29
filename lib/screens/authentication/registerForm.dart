import 'package:flutter/material.dart';
import 'package:zenst/databases/db_helper.dart';
import 'package:zenst/models/user.dart';
import 'package:zenst/screens/authentication/login_screen.dart';
import 'package:zenst/screens/authentication/registerSuccess.dart';

class RegisterForm extends StatefulWidget {
  final Function(int) setIsLogged;
  final User? user;
  const RegisterForm({super.key, this.user, required this.setIsLogged});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isAgreeTC = false;
  bool hidePassword = true;
  DatabaseHelper db = DatabaseHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController? name;
  TextEditingController? email;
  TextEditingController? password;

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
            builder: (context) => RegisterSuccess(
              setIsLogged: widget.setIsLogged,
            ),
          ));
    }
  }

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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
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
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.height / 3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/ilust-1.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Name',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: name,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill with your name.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'John Doe',
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
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
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Email',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill with your email.';
                                    }
                                    return null;
                                  },
                                  controller: email,
                                  decoration: InputDecoration(
                                    hintText: 'myemail@example.com',
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
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
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Password',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill with your password.';
                                    }
                                    if (value.length < 8) {
                                      return 'Minimum 8 characters.';
                                    }
                                    return null;
                                  },
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
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
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: FormField<bool>(
                                initialValue: isAgreeTC,
                                validator: (value) {
                                  if (value == null || !value) {
                                    return 'You must agree to the terms and conditions.';
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<bool> state) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 50,
                                            child: Checkbox(
                                              value: state.value,
                                              onChanged: (value) {
                                                state.didChange(value);
                                                setState(() {
                                                  isAgreeTC = value!;
                                                });
                                              },
                                              activeColor:
                                                  Colors.lightBlue[300],
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: RichText(
                                              softWrap: true,
                                              text: TextSpan(
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0),
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                      text:
                                                          'By signing up, you agree to our '),
                                                  TextSpan(
                                                      text:
                                                          'Terms & Conditions ',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .lightBlue[300])),
                                                  const TextSpan(text: 'and '),
                                                  TextSpan(
                                                      text: 'Privacy Policy',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .lightBlue[300])),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (state.hasError)
                                        Text(
                                          state.errorText!,
                                          style: TextStyle(
                                            color: Colors.red[300],
                                            fontSize: 12,
                                          ),
                                        ),
                                    ],
                                  );
                                },
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      upsertUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      backgroundColor: Colors.lightBlue[300]),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
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
                                  builder: (context) => LoginPage(
                                        setIsLogged: widget.setIsLogged,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          overlayColor: Colors.transparent,
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
    );
  }
}
