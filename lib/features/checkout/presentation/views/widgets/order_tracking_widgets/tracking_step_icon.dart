import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';

class TrackingStepIcon extends StatelessWidget {
  const TrackingStepIcon({
    super.key,
    required this.isDone,
    required this.isActive,
  });

  final bool isDone;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: _backgroundColor,
        shape: BoxShape.circle,
        border: isDone ? null : Border.all(color: AppColors.border, width: 2),
      ),
      child: isDone
          ? Icon(Icons.check_rounded, color: _iconColor, size: 20)
          : null,
    );
  }

  Color get _backgroundColor {
    if (!isDone) return Colors.white;
    return isActive
        ? AppColors.green1_500
        : AppColors.green1_500.withOpacity(0.15);
  }

  Color get _iconColor => isActive ? Colors.white : AppColors.green1_500;
}
