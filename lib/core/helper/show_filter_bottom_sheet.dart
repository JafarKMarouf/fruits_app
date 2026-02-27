import 'package:flutter/material.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/filter_bottom_sheet.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    ),
    builder: (_) => const FilterBottomSheet(),
  );
}
