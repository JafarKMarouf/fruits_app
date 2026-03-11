import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/custom_main_app_bar.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/fruit_item_grid_view.dart';

class BestSellingViewBody extends StatelessWidget {
  const BestSellingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: kTopPadding),
                  CustomMainAppBar(title: 'الأكثر مبيعاً'),
                  SizedBox(height: 24),
                ],
              ),
            ),
            FruitItemGridView(),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
