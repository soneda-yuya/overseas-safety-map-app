/// The subset of the BFF UserProfile the app actually renders. Matches the
/// Q4 Design [A] decision that the app reads / writes via BFF RPC, not
/// directly against Firestore — so we never see fcm_tokens individually,
/// only the count the server reports.
class UserProfile {
  const UserProfile({
    required this.uid,
    required this.favoriteCountryCds,
    required this.preference,
    required this.fcmTokenCount,
  });

  final String uid;
  final List<String> favoriteCountryCds;
  final NotificationPreference preference;
  final int fcmTokenCount;

  UserProfile copyWith({
    List<String>? favoriteCountryCds,
    NotificationPreference? preference,
    int? fcmTokenCount,
  }) {
    return UserProfile(
      uid: uid,
      favoriteCountryCds: favoriteCountryCds ?? this.favoriteCountryCds,
      preference: preference ?? this.preference,
      fcmTokenCount: fcmTokenCount ?? this.fcmTokenCount,
    );
  }
}

class NotificationPreference {
  const NotificationPreference({
    required this.enabled,
    required this.targetCountryCds,
    required this.infoTypes,
  });

  final bool enabled;
  final List<String> targetCountryCds;
  final List<String> infoTypes;

  NotificationPreference copyWith({
    bool? enabled,
    List<String>? targetCountryCds,
    List<String>? infoTypes,
  }) {
    return NotificationPreference(
      enabled: enabled ?? this.enabled,
      targetCountryCds: targetCountryCds ?? this.targetCountryCds,
      infoTypes: infoTypes ?? this.infoTypes,
    );
  }

  static const empty = NotificationPreference(
    enabled: false,
    targetCountryCds: [],
    infoTypes: [],
  );
}
