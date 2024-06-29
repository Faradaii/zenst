import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:zenst/models/bookmark.dart';
import 'package:zenst/databases/db_helper.dart';
import 'package:zenst/models/apis/videos.dart';
import 'package:zenst/screens/discover/components/videopost.dart';
import 'package:zenst/services/api_service.dart';

class Discover extends StatefulWidget {
  final int userIdLogged;
  const Discover({super.key, required this.userIdLogged});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  bool isExpandText = false;
  List<String> bookmarkedVideos = [];
  List<String> likedVideos = [];
  late Future<List<Video>> _videosFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _videosFuture = ApiService().fetchVideos();
  }

  void changebookmarkedVideos(String id, String cover) async {
    if (!bookmarkedVideos.contains(id)) {
      DatabaseHelper().insertBookmark(
          Bookmark(id: id, userId: widget.userIdLogged, imagePath: cover));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video Bookmarked!'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.lightBlue[400],
          duration: Duration(milliseconds: 500),
        ),
      );
      setState(() {
        bookmarkedVideos.add(id);
      });
    } else {
      DatabaseHelper().deleteBookmark(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video Unbookmarked!'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[400],
          duration: Duration(milliseconds: 500),
        ),
      );
      setState(() {
        bookmarkedVideos.remove(id);
      });
    }
  }

  void changeLikedVideos(String id) async {
    if (!likedVideos.contains(id)) {
      setState(() {
        likedVideos.add(id);
      });
    } else {
      setState(() {
        likedVideos.remove(id);
      });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      isExpandText = false;
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Video>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: JumpingDots(color: Colors.lightBlue[300]!));
          } else {
            final videos = snapshot.data!;
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final isVisible = index == _currentPageIndex;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.black,
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child:
                          VideoPost(video: videos[index], isVisible: isVisible),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height,
                        child: FrameVideoPost(context, videos, index))
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget FrameVideoPost(BuildContext context, videos, index) {
    String cvtInt(int i) {
      return i > 999
          ? '${i.toString().substring(0, i.toString().length - 3)}.${i.toString().substring(i.toString().length - 3, i.toString().length - 2)} K'
          : i.toString();
    }

    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        height: MediaQuery.of(context).size.height / 5,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: <Color>[Colors.black, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(99)),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(videos[index].author.avatar),
                                  fit: BoxFit.cover))),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            videos[index].author.nickname.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '@${videos[index].author.uniqueId}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: videos[index].title.toString().isEmpty ? 0 : 15,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: videos[index].title.toString().substring(
                          0,
                          videos[index].title.toString().length > 100
                              ? (isExpandText
                                  ? videos[index].title.toString().length
                                  : 100)
                              : videos[index].title.toString().length),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    if (videos[index].title.toString().length > 100)
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpandText = !isExpandText;
                            });
                          },
                          child: Text(
                            isExpandText ? '\t\tSee less' : '\t\tSee more',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                  ])),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        changeLikedVideos(videos[index].id.toString());
                      },
                      icon: Icon(Icons.favorite,
                          color:
                              likedVideos.contains(videos[index].id.toString())
                                  ? Colors.red[400]
                                  : const Color.fromRGBO(255, 255, 255, 0.85)),
                      iconSize: 40,
                    ),
                    Text(
                      likedVideos.contains(videos[index].id.toString())
                          ? cvtInt(videos[index].diggCount + 1)
                          : cvtInt(videos[index].diggCount),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chat_rounded,
                          color: const Color.fromRGBO(255, 255, 255, 0.85)),
                      iconSize: 40,
                    ),
                    Text(
                      videos[index].commentCount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        changebookmarkedVideos(videos[index].id.toString(),
                            videos[index].cover.toString());
                      },
                      icon: Icon(Icons.bookmark_outlined,
                          color: bookmarkedVideos
                                  .contains(videos[index].id.toString())
                              ? Colors.lightBlue[400]
                              : const Color.fromRGBO(255, 255, 255, 0.85)),
                      iconSize: 40,
                    ),
                    Text(
                      bookmarkedVideos.contains(videos[index].id.toString())
                          ? 'Saved'
                          : 'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(99)),
                        image: DecorationImage(
                            image: NetworkImage(videos[index].musicCover),
                            fit: BoxFit.cover))),
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
