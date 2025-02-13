class ChatMessage {
  int? id;
  final String text;
  final String? imageUrl;
  final int createdAt;
  final Author author;

  ChatMessage(
      {this.id,
      required this.text,
      required this.imageUrl,
      required this.createdAt,
      required this.author});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'author': author.userName,
      'createdAt': createdAt,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        id: json['id'] as int?,
        text: json['text'] as String,
        imageUrl: json['imageUrl'] as String?,
        createdAt: json['createdAt'] as int,
        author: Author(userName: json['author'] as String));
  }
}

class Author {
  String userName;

  Author({required this.userName});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(userName: json['username']);
  }
}
