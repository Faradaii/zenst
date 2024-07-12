import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:Zenst/models/apis/videos.dart';

class ApiService {
  final List keywordList = [
    'monitor%20mouse%20keyboard%20setup%20gaming',
    'setup%20workspace%20techtok',
    'techtok%20inspiration'
  ];

  final apiKeyGemini = "AIzaSyC3zlaQHxHOb5xEwK0XCSz3InTOaKH7wcQ";
  final apiUrlGemini = Uri.https('generativelanguage.googleapis.com',
      '/v1/models/gemini-1.5-flash:generateContent', {
    'key': "",
  });

  static Map<String, dynamic> body = {"contents": <Map<String, dynamic>>[]};

  Future<List<Video>> fetchVideos() async {
    final response = await http.get(
      Uri.parse(
          'https://tiktok-video-feature-summary.p.rapidapi.com/feed/search?keywords=${keywordList[Random().nextInt(keywordList.length)]}&count=10'),
      headers: {
        'x-rapidapi-key': '',
        'x-rapidapi-host': 'tiktok-video-feature-summary.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List videosJson = json['data']['videos'];
      return videosJson.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception(response);
    }
  }

  Future<String> postGeminiAI(String askText) async {
    body['contents']!.add(
      {
        "role": "user",
        "parts": [
          {"text": askText}
        ]
      },
    );

    final response = await http.post(
      apiUrlGemini,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    Map<String, dynamic> newContent = responseMap['candidates'][0]['content'];
    body['contents']!.add(newContent);

    return newContent['parts'][0]['text'].toString();
  }
}
