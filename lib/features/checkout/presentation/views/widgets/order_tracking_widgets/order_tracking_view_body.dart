import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_constants.dart';
import '../../../../../../core/widgets/custom_main_app_bar.dart';
import 'order_tracking_bloc_builder.dart';

class OrderTrackingViewBody extends StatelessWidget {
  const OrderTrackingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            SizedBox(height: kTopPadding),
            CustomMainAppBar(title: 'تتبع الطلب', isShowNotification: false),
            SizedBox(height: 24),
            Expanded(child: OrderTrackingBlocBuilder()),
          ],
        ),
      ),
    );
  }
}
