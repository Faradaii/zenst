import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:zenst/models/notification.dart';
import 'package:zenst/databases/db_helper.dart';

class NotificationPage extends StatefulWidget {
  final int userIdLogged;
  const NotificationPage({super.key, required this.userIdLogged});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationDB>> _notification;

  @override
  void initState() {
    super.initState();
    _notification =
        DatabaseHelper().getAllNotificationsUserId(widget.userIdLogged);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<NotificationDB>>(
        future: _notification,
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/ilust-3.png'),
                          fit: BoxFit.cover)),
                ),
                Text('Belum ada Notifikasi !')
              ],
            ));
          } else {
            final notif = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 1,
              ),
              scrollDirection: Axis.vertical,
              itemCount: notif.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          color: Colors.black,
                        ),
                        FittedBox(
                          fit: BoxFit.cover,
                          child: NotifBlock(
                              context,
                              notif[index].notifikasiHead,
                              notif[index].notifikasi),
                        ),
                      ],
                    ),
                    if (index == notif.length - 1)
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text('-- No more notifications --')),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget NotifBlock(BuildContext context, String notifHead, String notif) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.lightBlue[400],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.lightBlue,
              width: 1,
            )),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(99)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/zenst-logo.png'),
                        fit: BoxFit.cover))),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notifHead,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  Text(
                    notif,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
