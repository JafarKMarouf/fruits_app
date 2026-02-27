import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/search_text_field.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/fruit_item_grid_view.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/home_app_bar.dart';

import 'featured_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

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
                  HomeAppBar(),
                  SizedBox(height: 16),
                  SearchTextField(),
                  SizedBox(height: 12),
                  FeaturedList(),
                  SizedBox(height: 12),
                  BestSellingHeader(),
                  SizedBox(height: 8),
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
