import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/rpc/bff_client.dart';
import '../../../core/rpc/error_mapper.dart';
import '../../../core/rpc/mappers.dart';
// Import only the request types we need; exclude UserProfile / NotificationPreference
// from the generated proto which would collide with our domain VOs of the
// same name.
import '../../../gen/v1/safetymap.pb.dart'
    show
        GetProfileRequest,
        RegisterFcmTokenRequest,
        ToggleFavoriteCountryRequest,
        UpdateNotificationPreferenceRequest;
import '../domain/user_profile.dart';

class ProfileRemote {
  ProfileRemote(this._bff);

  final BffClient _bff;

  Future<UserProfile> getProfile() async {
    try {
      final res = await _bff.userProfile.getProfile(GetProfileRequest());
      return profileFromProto(res.profile);
    } catch (error) {
      throw mapRpcError(error);
    }
  }

  Future<UserProfile> toggleFavorite(String countryCd) async {
    try {
      final res = await _bff.userProfile.toggleFavoriteCountry(
        ToggleFavoriteCountryRequest(countryCd: countryCd),
      );
      return profileFromProto(res.profile);
    } catch (error) {
      throw mapRpcError(error);
    }
  }

  Future<void> updatePreference(NotificationPreference pref) async {
    try {
      await _bff.userProfile.updateNotificationPreference(
        UpdateNotificationPreferenceRequest(
          preference: preferenceToProto(pref),
        ),
      );
    } catch (error) {
      throw mapRpcError(error);
    }
  }

  Future<void> registerFcmToken({
    required String token,
    String deviceId = '',
  }) async {
    try {
      await _bff.userProfile.registerFcmToken(
        RegisterFcmTokenRequest(token: token, deviceId: deviceId),
      );
    } catch (error) {
      throw mapRpcError(error);
    }
  }
}

final profileRemoteProvider = Provider<ProfileRemote>(
  (ref) => ProfileRemote(ref.watch(bffClientProvider)),
);

/// Loads the current user's profile. Invalidate this provider to re-fetch
/// after a mutation (ToggleFavorite / UpdatePreference / RegisterFcmToken).
final profileProvider = FutureProvider.autoDispose<UserProfile>((ref) async {
  return ref.watch(profileRemoteProvider).getProfile();
});
