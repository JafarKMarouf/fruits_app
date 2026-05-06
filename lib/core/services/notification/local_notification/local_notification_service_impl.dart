import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fruits_app/core/services/notification/local_notification/local_notification_service.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class LocalNotificationServiceImpl implements LocalNotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  void Function(String?)? _onNotificationTap;

  @override
  void Function(String?)? get onNotificationTap => _onNotificationTap;

  @override
  set onNotificationTap(void Function(String?)? callback) {
    _onNotificationTap = callback;
  }

  @override
  Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onNotificationTap?.call(response.payload);
      },
    );

    // Request permission on Android 13+
    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? imageUrl,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          kNotificationChannelId,
          kNotificationChannelName,
          channelDescription: kNotificationChannnelDescription,
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  @override
  Future<void> showBigPictureNotification({
    required int id,
    required String title,
    required String body,
    required String imageUrl,
    String? payload,
  }) async {
    StyleInformation styleInfo;

    if (imageUrl.isNotEmpty) {
      try {
        final response = await http
            .get(Uri.parse(imageUrl))
            .timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
          final imageBytes = response.bodyBytes;
          styleInfo = BigPictureStyleInformation(
            ByteArrayAndroidBitmap(imageBytes),
            largeIcon: ByteArrayAndroidBitmap(imageBytes),
            contentTitle: title,
            summaryText: body,
            htmlFormatContentTitle: false,
            htmlFormatSummaryText: false,
          );
        } else {
          styleInfo = const DefaultStyleInformation(true, true);
        }
      } catch (_) {
        styleInfo = const DefaultStyleInformation(true, true);
      }
    } else {
      styleInfo = const DefaultStyleInformation(true, true);
    }

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          kNotificationChannelId,
          kNotificationChannelName,
          channelDescription: kNotificationChannnelDescription,
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: styleInfo,
          showWhen: true,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: payload,
    );
  }
}
