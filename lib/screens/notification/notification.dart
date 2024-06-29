import 'package:flutter/material.dart';
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
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return noNotification();
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
                            child: notifBlock(
                                context,
                                notif[index].notifikasiHead,
                                notif[index].notifikasi,
                                notif[index].id!),
                          ),
                        ],
                      ),
                      if (index == notif.length - 1)
                        Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 10),
                            child: const Text('-- No more notifications --')),
                    ],
                  );
                });
          }
        },
      ),
    );
  }

  Widget notifBlock(
      BuildContext context, String notifHead, String notif, int id) {
    return Stack(
      children: [
        Container(
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
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(99)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/zenst-logo.png'),
                            fit: BoxFit.cover))),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifHead,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      Text(
                        notif,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 5,
            top: 8,
            child: IconButton(
              onPressed: () {
                DatabaseHelper()
                    .deleteNotification(id.toString())
                    .then((value) {
                  setState(() {
                    _notification = DatabaseHelper()
                        .getAllNotificationsUserId(widget.userIdLogged);
                  });
                });
              },
              icon: const Icon(Icons.cancel),
              color: Colors.white,
            )),
      ],
    );
  }

  Widget noNotification() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.width / 1.5,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/ilust-3.png'),
                  fit: BoxFit.cover)),
        ),
        const Text('No Notification yet !')
      ],
    ));
  }
}
