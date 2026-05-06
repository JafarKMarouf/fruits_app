import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationLoadingUI extends StatelessWidget {
  const NotificationLoadingUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) => const _NotificationSkeletonItem(),
      ),
    );
  }
}

class _NotificationSkeletonItem extends StatelessWidget {
  const _NotificationSkeletonItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          // ── Thumbnail Skeleton ─────────────────────────────────────
          Container(
            width: 59,
            height: 59,
            decoration: BoxDecoration(
              color: AppColors.grayscale300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(width: 13),

          // ── Text Content Skeleton ──────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.grayscale300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.grayscale300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ── Metadata Skeleton ──────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 40,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.grayscale300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 4,
                backgroundColor: AppColors.grayscale300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
