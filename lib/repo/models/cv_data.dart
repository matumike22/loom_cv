class CvData {
  final String id, title, userId;
  final Map<String, dynamic> content;
  final DateTime createdAt, updatedAt;

  CvData({
    required this.id,
    required this.title,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CvData.fromJson(Map<String, dynamic> json) {
    return CvData(
      id: json['id'] as String,
      title: json['title'] as String,
      userId: json['userId'] as String,
      content: json['content'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Copy with method
  CvData copyWith({
    String? id,
    String? title,
    String? userId,
    Map<String, dynamic>? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CvData(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
