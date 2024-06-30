import 'package:flutter/material.dart';
import 'package:Zenst/databases/db_helper.dart';
import 'package:Zenst/models/user.dart';
import 'package:Zenst/screens/profile/itemSavedPage.dart';
import 'package:Zenst/screens/profile/profileDetailPage.dart';

class ProfilePage extends StatefulWidget {
  final Function() setLoggedOut;
  final int userIdLogged;
  const ProfilePage(
      {super.key, required this.setLoggedOut, required this.userIdLogged});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User?> _user;

  @override
  void initState() {
    super.initState();
    _user = DatabaseHelper().getUserById(widget.userIdLogged);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<User?>(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return const Text('Error');
              } else {
                final user = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(children: [
                    Container(
                        margin: const EdgeInsets.only(top: 25, bottom: 10),
                        width: MediaQuery.of(context).size.width / 2.8,
                        height: MediaQuery.of(context).size.width / 2.8,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.lightBlue[100]!),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(99)),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/faradaii.png'),
                                fit: BoxFit.cover))),
                    Text(user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 32)),
                    Text(
                        '@${user.email.substring(0, !user.email.contains('@') ? user.email.length : user.email.indexOf('@'))}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18)),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileDetailPage(
                                      user: user,
                                    )));
                        if (result != 0) {
                          setState(() {
                            _user = DatabaseHelper()
                                .getUserById(widget.userIdLogged);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.lightBlue,
                        fixedSize: MediaQuery.of(context).size.width > 600
                            ? const Size(400, 50)
                            : const Size(200, 50),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buttonSetting('Saved Item(s)', Icons.bookmark, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ItemSavedPage(userIdLogged: user.id!)));
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        buttonSetting('About Zenst', Icons.info_sharp,
                            () => showAboutAlert()),
                        const SizedBox(
                          height: 10,
                        ),
                        buttonSetting(
                            'Logout',
                            Icons.power_settings_new_rounded,
                            widget.setLoggedOut,
                            Colors.red),
                      ],
                    )
                  ]),
                );
              }
            }));
  }

  Future<void> showAboutAlert() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Center(
          child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 1,
              child: SizedBox(
                height: size.height * .6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        width: size.width - (size.width * 1 / 4),
                        top: (size.height * .2) / 2,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 80),
                                const Text('About Zenst',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                const Text('version 0.0.1 - @Faradaii',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'Zenst is designed to provide a unique, interactive and fun social media experience for those of you who like to share ideas and discover interesting products.',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.lightBlue,
                                        fixedSize: Size(size.width * 0.5, 10)),
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: const EdgeInsets.only(top: 25, bottom: 10),
                          width: size.width / 3,
                          height: size.width / 3,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.lightBlue[100]!),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(99)),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/zenst-logo.png'),
                                  fit: BoxFit.cover))),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget buttonSetting(String text, IconData icon, Function? func,
      [Color? c = Colors.lightBlue]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            func!();
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            overlayColor: Colors.transparent,
            shadowColor: Colors.transparent,
            side: BorderSide(color: c!, width: 0.3),
            fixedSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: c,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(text,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 18)),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 24,
                color: c,
              )
            ],
          ),
        ),
      ],
    );
  }
}
