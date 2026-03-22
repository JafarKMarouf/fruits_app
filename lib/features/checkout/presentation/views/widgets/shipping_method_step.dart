import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/shipping_item.dart';

import '../../../domain/entities/shipping_option.dart';

class ShippingMethodStep extends StatefulWidget {
  const ShippingMethodStep({super.key});

  @override
  State<ShippingMethodStep> createState() => _ShippingMethodStepState();
}

class _ShippingMethodStepState extends State<ShippingMethodStep> {
  int _selectedIndex = -1;

  final List<ShippingOption> _options = const [
    ShippingOption(
      title: 'الدفع عند الاستلام',
      subtitle: 'التسليم من المكان',
      price: '40 جنيه',
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
    return Column(
      children: List.generate(_options.length, (index) {
        return ShippingItem(
          option: _options[index],
          isSelected: _selectedIndex == index,
          onTap: () => setState(() => _selectedIndex = index),
        );
      }),
    );
  }
}
