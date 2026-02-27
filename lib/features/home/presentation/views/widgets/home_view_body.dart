import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/search_text_field.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/fruit_item_grid_view.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/show_more_best_selling.dart';

import 'featured_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.onShowMoreTapped,
    required this.onSearchTapped,
    required this.onNotificationTapped,
  });

  final VoidCallback onShowMoreTapped;
  final VoidCallback onSearchTapped;
  final VoidCallback onNotificationTapped;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: kTopPadding),
                  HomeAppBar(onNotificationTapped: onNotificationTapped),
                  const SizedBox(height: 16),
                  SearchTextField(readOnly: true, onTap: onSearchTapped),
                  const SizedBox(height: 12),
                  const FeaturedList(),
                  const SizedBox(height: 12),
                  ShowMoreBestSelling(onTap: onShowMoreTapped),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const FruitItemGridView(),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
