
class Video {
  final String id;
  final String title;
  final String cover;
  final String videoUrl;
  final String musicCover;
  final Author author;
  final int diggCount;
  final int commentCount;

  Video({
    required this.id,
    required this.title,
    required this.cover,
    required this.videoUrl,
    required this.musicCover,
    required this.author,
    required this.diggCount,
    required this.commentCount,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['video_id'],
      title: json['title'],
      cover: json['cover'],
      videoUrl: json['play'],
      musicCover: json['music_info']['cover'],
      author: Author.fromJson(json['author']),
      diggCount: json['digg_count'],
      commentCount: json['comment_count'],
    );
  }
}

class Author {
  final String uniqueId;
  final String nickname;
  final String avatar;

  Author({
    required this.uniqueId,
    required this.nickname,
    required this.avatar,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      uniqueId: json['unique_id'],
      nickname: json['nickname'],
      avatar: json['avatar'],
    );
  }
}
