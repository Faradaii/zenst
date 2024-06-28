// video_model.dart

class Video {
  final String id;
  final String title;
  final String cover;
  final String videoUrl;
  final String musicUrl;
  final int duration;
  final int createTime;
  final String region;
  final Author author;

  Video({
    required this.id,
    required this.title,
    required this.cover,
    required this.videoUrl,
    required this.musicUrl,
    required this.duration,
    required this.createTime,
    required this.region,
    required this.author,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['aweme_id'],
      title: json['title'],
      cover: json['cover'],
      videoUrl: json['play'],
      musicUrl: json['music_info']['play'],
      duration: json['duration'],
      createTime: json['create_time'],
      region: json['region'],
      author: Author.fromJson(json['author']),
    );
  }
}

class Author {
  final String id;
  final String uniqueId;
  final String nickname;
  final String avatar;

  Author({
    required this.id,
    required this.uniqueId,
    required this.nickname,
    required this.avatar,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      uniqueId: json['unique_id'],
      nickname: json['nickname'],
      avatar: json['avatar'],
    );
  }
}
