abstract class PushNotificationService {
  Future<void> init();
  Future<String?> getToken();
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  Stream<String> get onTokenRefresh;
}
