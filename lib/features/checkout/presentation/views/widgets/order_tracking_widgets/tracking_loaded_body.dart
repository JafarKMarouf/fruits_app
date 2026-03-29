import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/core/widgets/bottom_nav_bar/app_shell.dart';

import '../../../../domain/entities/order_tracking_entity/order_tracking_entity.dart';
import 'order_info_card.dart';
import 'tracking_timeline.dart';

class TrackingLoadedBody extends StatelessWidget {
  const TrackingLoadedBody({super.key, required this.order});

  final OrderTrackingEntity order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OrderInfoCard(order: order),
        const SizedBox(height: 24),
        Expanded(child: TrackingTimeline(order: order)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kTopPadding),
          child: AppPrimaryButton(
            text: 'الرئيسية',
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppShell.routeName,
              (_) => false,
            ),
          ),
        ),
      ],
    );
  }
}
