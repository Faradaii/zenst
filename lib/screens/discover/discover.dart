import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:zenst/models/apis/videos.dart';
import 'package:zenst/screens/discover/components/videopost.dart';
import 'package:zenst/services/api_service.dart';

class Discover extends StatefulWidget {
  final int userIdLogged;
  const Discover({super.key, required this.userIdLogged});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  late Future<List<Video>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = ApiService().fetchVideos();
    Wakelock.enable();
  }

  void _onPageChanged(int index) {
    setState(() {
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
            return Center(child: Text('Error: ${snapshot.error}'));
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
                        child: Text(
                          videos[index].title,
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
