import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import '../../../../features/home/presentation/views/notification_view.dart';
import '../../../../features/products/presentation/views/products_view.dart';
import '../../../../firebase_options.dart';
import '../../../helper/app_navigator.dart';
import '../local_notification/local_notification_service.dart';
import 'push_notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 1. Initialize Firebase for this isolate
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  log('FCM Background message: ${message.messageId}');

  // 2. Initialize Local Notifications independently
  final plugin = FlutterLocalNotificationsPlugin();

  await plugin.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    ),
  );

  // 3. Extract notification or data to show the alert
  final notification = message.notification;

  final title = notification?.title ?? message.data['title'] ?? '';
  final body = notification?.body ?? message.data['body'] ?? '';

  if (title.isEmpty && body.isEmpty) return;

  if (notification != null) {
    await plugin.show(
      id: notification.hashCode,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          kNotificationChannelId,
          kNotificationChannelName,
          channelDescription: kNotificationChannnelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data['productId'],
    );
  }
}

class PushNotificationServiceImpl implements PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotification;

  PushNotificationServiceImpl(this._localNotification);

  @override
  Future<void> init() async {
    // ── 1. Request permission
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
      _handleMessageNavigation(message);
    });

    // 5. App launched from terminated state via notification
    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      log('FCM Initial message: ${initialMessage.data}');
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleMessageNavigation(initialMessage);
      });
    }
    _localNotification.onNotificationTap = (String? payload) {
      _navigateByPayload(payload);
    };
    // 6. Subscribe all customers to global topic
    await subscribeToTopic('new_products');
  }

  void _handleMessageNavigation(RemoteMessage message) {
    final productId = message.data['productId'];
    _navigateByPayload(productId);
  }

  void _navigateByPayload(String? productId) {
    if (productId != null && productId.isNotEmpty) {
      AppNavigator.pushNamed(ProductsView.routeName, arguments: productId);
    } else {
      AppNavigator.pushNamed(NotificationView.routeName);
    }
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
  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      log('FCM token deleted');
    } catch (e) {
      log('Error deleting FCM token: $e');
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
    log('Unsubscribed from topic: $topic');
  }

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}
