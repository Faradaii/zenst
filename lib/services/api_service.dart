import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zenst/models/apis/videos.dart';

class ApiService {
  static const _keywordVideo = 'ai%disturbing%20time%20traveler';
  static const String apiUrlTiktok =
      "https://tiktok-video-feature-summary.p.rapidapi.com/feed/search?keywords=$_keywordVideo&count=10";

  final apiKeyGemini = "AIzaSyC3zlaQHxHOb5xEwK0XCSz3InTOaKH7wcQ";
  final apiUrlGemini = Uri.https('generativelanguage.googleapis.com',
      '/v1/models/gemini-1.5-flash:generateContent', {
    'key': "AIzaSyC3zlaQHxHOb5xEwK0XCSz3InTOaKH7wcQ",
  });

  static Map<String, dynamic> body = {"contents": <Map<String, dynamic>>[]};

  Future<List<Video>> fetchVideos() async {
    final response = await http.get(
      Uri.parse(apiUrlTiktok),
      headers: {
        'x-rapidapi-key': '558053a9e4msh0eebb74f46c3e4ap123125jsn753cacd6dd51',
        'x-rapidapi-host': 'tiktok-video-feature-summary.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List videosJson = json['data']['videos'];
      return videosJson.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
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
