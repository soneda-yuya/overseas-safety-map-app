/// Local-only record of a received FCM message. Persisted to
/// `shared_preferences` so the user can browse recent notifications even
/// after the system tray clears them. Kept minimal — full incident detail
/// is fetched on tap via `GetSafetyIncident`.
class NotificationEntry {
  const NotificationEntry({
    required this.receivedAt,
    required this.title,
    required this.body,
    required this.keyCd,
  });

  final DateTime receivedAt;
  final String title;
  final String body;
  final String keyCd;

  Map<String, Object?> toJson() => {
        'receivedAt': receivedAt.toIso8601String(),
        'title': title,
        'body': body,
        'keyCd': keyCd,
      };

  factory NotificationEntry.fromJson(Map<String, Object?> json) {
    return NotificationEntry(
      receivedAt:
          DateTime.parse(json['receivedAt']! as String),
      title: json['title']! as String,
      body: json['body']! as String,
      keyCd: json['keyCd']! as String,
    );
  }
}
