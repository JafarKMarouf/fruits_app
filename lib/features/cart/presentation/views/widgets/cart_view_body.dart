import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/widgets/custom_main_app_bar.dart';
import 'cart_header.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: kTopPadding),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: CustomMainAppBar(
                    title: 'السلة',
                    isShowNotification: false,
                  ),
                ),
                SizedBox(height: 24),
                CartHeader(),
              ],
            ),
          ),
          // const ProductsGridViewBlocBuilder(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
