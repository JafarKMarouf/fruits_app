import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';

import '../../../../../core/utils/styles/app_colors.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key, required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFEBF9F1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Text(
            'لديك $count منتجات في سله التسوق',
            style: AppTextStyles.styleRegular13.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
