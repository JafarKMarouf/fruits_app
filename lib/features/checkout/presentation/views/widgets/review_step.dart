import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/review_item.dart';

import 'delivery_address_section.dart';
import 'order_summary_section.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ReviewItem(title: 'ملخص الطلب : ', child: OrderSummarySection()),
        SizedBox(height: 16),
        ReviewItem(
          title: 'يرجى تأكيد  طلبك : ',
          child: DeliveryAddressSection(),
        ),
      ],
    );
  }
}
