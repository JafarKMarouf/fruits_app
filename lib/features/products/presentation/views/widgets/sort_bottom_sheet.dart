import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

enum SortOption { priceLowToHigh, priceHighToLow, alphabetical }

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  SortOption? _selected;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 20,
          right: 20,
          bottom: 28,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Drag handle ──────────────────────────────────────────────
            Center(
              child: Container(
                width: 60,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF131F46),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Title ────────────────────────────────────────────────────
            const AppTextWidget(
              text: 'ترتيب حسب :',
              style: AppTextStyles.styleBold19,
            ),
            const SizedBox(height: 10),

            // ── Options ──────────────────────────────────────────────────
            _SortTile(
              label: 'السعر ( الأقل الى الأعلى )',
              value: SortOption.priceLowToHigh,
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v),
            ),
            _SortTile(
              label: 'السعر ( الأعلى الى الأقل )',
              value: SortOption.priceHighToLow,
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v),
            ),
            _SortTile(
              label: 'الأبجديه',
              value: SortOption.alphabetical,
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v),
            ),
            const SizedBox(height: 20),

            // ── Filter button ────────────────────────────────────────────
            AppPrimaryButton(
              text: 'تصفيه',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  final String label;
  final SortOption value;
  final SortOption? groupValue;
  final ValueChanged<SortOption?> onChanged;

  const _SortTile({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<SortOption>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: AppColors.primaryDark,
      contentPadding: EdgeInsets.zero,
      title: AppTextWidget(text: label, style: AppTextStyles.styleBold13),
    );
  }
}
