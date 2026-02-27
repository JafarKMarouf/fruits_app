import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  static const routeName = 'notification-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: NotificationViewBody());
  }
}
