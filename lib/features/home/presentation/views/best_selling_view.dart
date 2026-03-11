import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/best_selling_view_body.dart';

class BestSellingView extends StatelessWidget {
  const BestSellingView({super.key});

  static const routeName = 'best-selling-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BestSellingViewBody());
  }
}
