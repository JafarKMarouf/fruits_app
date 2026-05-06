import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/core/widgets/custom_error_widget.dart';
import 'package:fruits_app/core/widgets/custom_main_app_bar.dart';
import 'package:fruits_app/features/home/presentation/manage/notification/notification_cubit.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/notification_loading_ui.dart';

import 'notification_item.dart';
import 'notification_section_header.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: CustomMainAppBar(title: 'الاشعارات'),
          ),
          // const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return switch (state) {
                  NotificationInitial() => const SizedBox.shrink(),
                  NotificationLoading() => const NotificationLoadingUI(),
                  NotificationFailure(:final message) => CustomErrorWidget(
                    errorMessage: message,
                    onRetry: () =>
                        context.read<NotificationCubit>().getNotifications(),
                  ),
                  NotificationLoaded() => _NotificationsContent(state: state),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsContent extends StatelessWidget {
  const _NotificationsContent({required this.state});

  final NotificationLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    final unread = state.unreadNotifications;
    final read = state.readNotifications;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              if (unread.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: NotificationSectionHeader(
                    label: 'جديد',
                    count: unread.length,
                    isAllSelected:
                        false, // unread items are never "all selected"
                    onSelectAll: (_) => cubit.markAllAsRead(),
                  ),
                ),
                const SizedBox(height: 16),
                ...unread.map(
                  (n) => NotificationItem(
                    notification: n,
                    onTap: () => cubit.markAsRead(n.id),
                  ),
                ),
                const SizedBox(height: 11),
              ],

              // ── Read / earlier section ──────────────────────────────────
              if (read.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: NotificationSectionHeader(
                    label: 'في وقت سابق',
                    count: read.length,
                    isAllSelected: true,
                    onSelectAll: (_) {},
                  ),
                ),
                const SizedBox(height: 16),
                ...read.map(
                  (n) => NotificationItem(notification: n, onTap: () {}),
                ),
              ],

              // ── Empty state ─────────────────────────────────────────────
              if (state.notifications.isEmpty)
                const _EmptyNotificationsWidget(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyNotificationsWidget extends StatelessWidget {
  const _EmptyNotificationsWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: AppTextWidget(
          'لا توجد اشعارات',
          style: AppTextStyles.styleBold16,
        ),
      ),
    );
  }
}
