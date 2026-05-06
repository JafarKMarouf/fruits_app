import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/core/widgets/custom_network_image.dart';
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.transparent
              : AppColors.green500.withOpacity(0.06),
        ),
        child: Row(
          children: [
            // ── Thumbnail ───────────────────────────────────────────────
            _NotificationThumbnail(imageUrl: notification.imageUrl),

            const SizedBox(width: 13),

            // ── Text ─────────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppTextStyles.styleSemiBold13.copyWith(
                      color: const Color(0xFF313131),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                  ),
                  if (notification.body.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: AppTextStyles.styleRegular13.copyWith(
                        color: AppColors.grayscale400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ── Timestamp + unread dot ───────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppTextWidget(
                  _formatTimestamp(notification.createdAt.toDate()),
                  style: AppTextStyles.styleRegular13.copyWith(
                    color: AppColors.grayscale400,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedOpacity(
                  opacity: notification.isRead ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.green500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Relative time formatting ─────────────────────────────────────────────
  String _formatTimestamp(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} س';
    if (diff.inDays == 1) return 'أمس';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} أيام';
    return '${date.day}/${date.month}/${date.year}';
  }
}

// ── Thumbnail (handles network vs. placeholder gracefully) ───────────────────
class _NotificationThumbnail extends StatelessWidget {
  const _NotificationThumbnail({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? CustomNetworkImage(imageUrl: imageUrl!, width: 59, height: 59)
          : const SizedBox(),
      // : Image.asset(
      //     AppImages.placeholder,
      //     width: 59,
      //     height: 59,
      //     fit: BoxFit.cover,
      //   ),
    );
  }
}
