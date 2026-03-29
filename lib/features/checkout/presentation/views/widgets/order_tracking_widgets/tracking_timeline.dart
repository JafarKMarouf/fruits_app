import 'package:flutter/material.dart';

import '../../../../domain/entities/order_tracking_entity/order_status.dart';
import '../../../../domain/entities/order_tracking_entity/order_tracking_entity.dart';
import 'tracking_timeline_item.dart';

class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({super.key, required this.order});

  final OrderTrackingEntity order;

  @override
  Widget build(BuildContext context) {
    const steps = OrderStatus.values;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (_, index) {
        final step = steps[index];
        final isDone = step.index <= order.status.index;
        final isActive = step == order.status;
        final isLast = index == steps.length - 1;

        return TrackingTimelineItem(
          step: step,
          isDone: isDone,
          isActive: isActive,
          isLast: isLast,
          // Show the order date only on the first completed step
          date: isDone && step.index == 0 ? order.createdAt : null,
        );
      },
    );
  }
}
