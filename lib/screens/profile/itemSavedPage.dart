import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:zenst/databases/db_helper.dart';
import 'package:zenst/models/bookmark.dart';

class ItemSavedPage extends StatefulWidget {
  final int userIdLogged;
  const ItemSavedPage({super.key, required this.userIdLogged});

  @override
  State<ItemSavedPage> createState() => _ItemSavedPageState();
}

class _ItemSavedPageState extends State<ItemSavedPage> {
  late Future<List<Bookmark>> _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = DatabaseHelper().getAllBookmarksUserId(widget.userIdLogged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bookmarked"),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Bookmark>>(
                future: _bookmarked,
                builder: (context, snapshot) {
                  if (!snapshot.hasError && snapshot.hasData) {
                    final bookmarked = snapshot.data!;
                    if (bookmarked.isEmpty) {
                      return Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width / 1.5,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/ilust-3.png'),
                                    fit: BoxFit.cover)),
                          ),
                          const Text('No bookmark yet !')
                        ],
                      ));
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 300,
                            childAspectRatio: 1.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: bookmarked.length,
                          padding: const EdgeInsets.all(5),
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 3,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          bookmarked[index].imagePath),
                                      fit: BoxFit.cover)),
                            );
                          });
                    }
                  } else {
                    return Center(
                      child: JumpingDots(
                        color: Colors.lightBlue[300]!,
                        radius: 10,
                        numberOfDots: 3,
                        animationDuration: const Duration(milliseconds: 600),
                      ),
                    );
                  }
                })));
  }
}
