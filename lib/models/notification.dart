class AppNotification {
  final int id;
  final String title;
  final String body;
  final String createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      createdAt: json['created_at'],
    );
  }
}
