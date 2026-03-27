import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/shipping_item.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/shipping_option.dart';

class ShippingMethodStep extends StatefulWidget {
  const ShippingMethodStep({super.key});

  @override
  State<ShippingMethodStep> createState() => _ShippingMethodStepState();
}

class _ShippingMethodStepState extends State<ShippingMethodStep>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _selectedIndex = -1;
  static const List<ShippingOption> _options = [
    ShippingOption(
      title: 'الدفع عند الاستلام',
      subtitle: 'التسليم من المكان',
      price: '+40',
      isFree: false,
    ),
    ShippingOption(
      title: 'اشتري الان وادفع لاحقا',
      subtitle: 'يرجي تحديد طريقه الدفع',
      price: 'مجاني',
      isFree: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: List.generate(_options.length, (index) {
        return ShippingItem(
          option: _options[index],
          isSelected: _selectedIndex == index,
          onTap: () => setState(() {
            context.read<OrderInputEntity>().payWithCash = index == 0;
            setState(() => _selectedIndex = index);
          }),
        );
      }),
    );
  }
}
