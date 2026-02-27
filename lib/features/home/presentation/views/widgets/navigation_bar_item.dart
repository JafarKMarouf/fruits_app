import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/home/domain/entities/bottom_navigation_bar_entity.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.isSelected,
    required this.bottomNavigationBarEntity,
    required this.onTap,
  });

  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: isSelected
            ? Container(
                key: const ValueKey(true),
                decoration: ShapeDecoration(
                  color: const Color(0xFFEEEEEE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: AppColors.green1_500,
                        shape: const OvalBorder(),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          bottomNavigationBarEntity.activeIcon,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppTextWidget(
                      text: bottomNavigationBarEntity.title,
                      style: AppTextStyles.styleSemiBold11.copyWith(
                        color: AppColors.green1_500,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              )
            : Padding(
                key: const ValueKey(false),
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(bottomNavigationBarEntity.inactiveIcon),
              ),
      ),
    );
  }
}
