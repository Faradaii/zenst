import 'package:flutter/material.dart';
import 'package:zenst/databases/db_helper.dart';
import 'package:zenst/models/user.dart';

class ProfileDetailPage extends StatefulWidget {
  final User user;
  const ProfileDetailPage({super.key, required this.user});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  TextEditingController? name;
  TextEditingController? email;
  TextEditingController? password;

  @override
  void initState() {
    name = TextEditingController(text: widget.user.name);
    email = TextEditingController(text: widget.user.email);
    password = TextEditingController(text: widget.user.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/faradaii.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.lightBlue[500]!, width: 2),
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.lightBlue[500]!, width: 2),
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.lightBlue[500]!, width: 2),
                        ),
                        hintText: '**********',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.user.name = name!.text;
                          widget.user.email = email!.text;
                          widget.user.password = password!.text;
                          DatabaseHelper()
                              .updateUser(User(
                                  id: widget.user.id,
                                  email: email!.text,
                                  name: name!.text,
                                  password: password!.text))
                              .then((value) {
                            Navigator.pop(context, value);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        backgroundColor: Colors.lightBlue[300],
                        padding: const EdgeInsets.all(0),
                        visualDensity: VisualDensity.compact,
                        elevation: 0,
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
