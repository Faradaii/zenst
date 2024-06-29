import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:zenst/services/api_service.dart';
import 'package:typewritertext/typewritertext.dart';

class Assist extends StatefulWidget {
  const Assist({super.key});

  @override
  State<Assist> createState() => _AssistState();
}

class ChatMessage {
  final String text;
  final bool isSentByMe;

  ChatMessage({required this.text, required this.isSentByMe});
}

class _AssistState extends State<Assist> {
  List<ChatMessage> messages = [];
  bool isFetching = false;
  bool isFinishedAnimation = true;
  ScrollController _scrollController = ScrollController();
  List<String> askIdeas = [
    "Tips membuat setup workspace",
    "Monitor atau Keyboard dahulu?",
    "Berikan saran tone estetik untuk workspace"
  ];
  TextEditingController _controller = TextEditingController();

  void changeIsFetching() {
    setState(() {
      isFetching = !isFetching;
      changeIsFinishedAnimation(false);
    });
  }

  void changeIsFinishedAnimation(bool value) {
    setState(() {
      isFinishedAnimation = value;
    });
    if (isFinishedAnimation) {
      _scrollToBottom();
    }
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(text: _controller.text, isSentByMe: true));
        changeIsFetching();
        _scrollToBottom();
      });

      String userMessage = _controller.text;
      _controller.clear();

      String text = await ApiService().postGeminiAI(userMessage);

      setState(() {
        changeIsFetching();
        messages.add(ChatMessage(text: text, isSentByMe: false));
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Column(
                    children: messages.map((message) {
                      return Align(
                        alignment: message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: EdgeInsets.fromLTRB(
                              message.isSentByMe ? 100 : 10,
                              5,
                              message.isSentByMe ? 10 : 100,
                              5),
                          decoration: BoxDecoration(
                            color: message.isSentByMe
                                ? Colors.blue
                                : const Color.fromARGB(255, 237, 237, 237),
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20),
                                topRight: const Radius.circular(20),
                                bottomRight: Radius.circular(
                                    message.isSentByMe ? 0 : 20),
                                bottomLeft: Radius.circular(
                                    message.isSentByMe ? 20 : 0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TypeWriter.text(
                                duration: Duration(
                                    milliseconds:
                                        (message.text.length / 200).round()),
                                repeat: false,
                                enabled: !isFinishedAnimation,
                                onChanged: (value) => !isFinishedAnimation
                                    ? _scrollToBottom()
                                    : null,
                                onFinished: isFinishedAnimation
                                    ? (value) {
                                        changeIsFinishedAnimation(true);
                                      }
                                    : null,
                                message.text,
                                maintainSize: false,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: message.isSentByMe
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (isFetching)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            JumpingDots(
                              color: Colors.lightBlue[300]!,
                              radius: 10,
                              numberOfDots: 3,
                              animationDuration: const Duration(milliseconds: 600),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 30,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: askIdeas.length,
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 3,
                          ),
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.lightBlue[300],
                              shadowColor: Colors.transparent,
                              overlayColor: Colors.transparent,
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.text = askIdeas[index];
                              });
                            },
                            child: Text(
                              askIdeas[index],
                              style: const TextStyle(color: Colors.white),
                            ));
                      }),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: 'Minta saran ke Gemini...',
                                fillColor: Colors.black,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlue, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: _sendMessage,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Powered by ', style: TextStyle(fontSize: 12)),
                          Icon(
                            Icons.auto_awesome,
                            size: 12,
                            color: Colors.lightBlue[300],
                          ),
                          const Text(' Gemini AI', style: TextStyle(fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
