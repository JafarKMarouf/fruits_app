import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/home/domain/entities/notification_entity.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationEntity notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: MediaQuery.sizeOf(context).width - 35,
            top: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead
                    ? Colors.transparent
                    : AppColors.green1_500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: notification.isSelected
                  ? Colors.green.withOpacity(0.06)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    notification.imageUrl,
                    width: 59,
                    height: 59,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 13),
                // ── Text content ─────────────────────────────────────
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: notification.boldAmount,
                          style: AppTextStyles.styleSemiBold16.copyWith(
                            color: const Color(0xFFEB5757),
                          ),
                        ),
                        TextSpan(
                          text: notification.title,
                          style: AppTextStyles.styleSemiBold13.copyWith(
                            color: const Color(0xFF313131),
                          ),
                        ),
                      ],
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: 13),
                AppTextWidget(
                  notification.time,
                  style: AppTextStyles.styleRegular13.copyWith(
                    color: AppColors.grayscale400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
