import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../local_notification/local_notification_service.dart';
import 'push_notification_service.dart';

// ⚠️ Must be top-level for FCM background handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('FCM Background message: ${message.messageId}');
}

class PushNotificationServiceImpl implements PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotification;

  PushNotificationServiceImpl(this._localNotification);

  @override
  Future<void> init() async {
    // 1. Request permission
    final NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('FCM permission: ${settings.authorizationStatus}');

    // 2. Register background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 3. Foreground handler — show local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('FCM Foreground: ${message.notification?.title}');
      final notification = message.notification;
      if (notification != null) {
        _localNotification.showBigPictureNotification(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          title: notification.title ?? '',
          body: notification.body ?? '',
          imageUrl: message.data['imageUrl'] ?? '',
          payload: message.data['productId'],
        );
      }
    });

    // 4. App opened from notification (background → foreground)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('FCM onMessageOpenedApp: ${message.data}');
      // Navigation handled by payload in local notification tap
    });

    // 5. App launched from terminated state via notification
    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      log('FCM Initial message: ${initialMessage.data}');
    }

    // 6. Subscribe all customers to global topic
    await subscribeToTopic('new_products');
  }

  @override
  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();
      log('FCM Token: $token');
      return token;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    log('Subscribed to topic: $topic');
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}
