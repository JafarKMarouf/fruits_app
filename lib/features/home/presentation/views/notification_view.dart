import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/notification_view_body.dart';

import '../../../../core/services/get_it_service.dart';
import '../manage/notification/notification_cubit.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  static const routeName = 'notification-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationCubit>()..getNotifications(),
      child: const Scaffold(body: NotificationViewBody()),
    );
  }
}
