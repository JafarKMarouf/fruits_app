import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(150, 300);

  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController(
      text: _priceRange.start.toInt().toString(),
    );
    _maxController = TextEditingController(
      text: _priceRange.end.toInt().toString(),
    );
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _onRangeChanged(RangeValues values) {
    setState(() {
      _priceRange = values;
      _minController.text = values.start.toInt().toString();
      _maxController.text = values.end.toInt().toString();
    });
  }

  void _onMinChanged(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null && parsed < _priceRange.end) {
      setState(() => _priceRange = RangeValues(parsed, _priceRange.end));
    }
  }

  void _onMaxChanged(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null && parsed > _priceRange.start) {
      setState(() => _priceRange = RangeValues(_priceRange.start, parsed));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          top: 12,
          left: 20,
          right: 20,
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
              'تصنيف حسب :',
              style: AppTextStyles.styleBold19,
            ),
            const SizedBox(height: 20),

            // ── Price label ──────────────────────────────────────────────
            Row(
              children: [
                SvgPicture.asset(AppImages.imagesTag),
                const SizedBox(width: 6),
                const AppTextWidget(
                  'السعر :',
                  style: AppTextStyles.styleBold13,
                ),
              ],
            ),
            const SizedBox(height: 14),

            // ── Min / Max text fields ────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _PriceField(
                    controller: _maxController,
                    onChanged: _onMaxChanged,
                  ),
                ),
                const SizedBox(width: 10),
                const AppTextWidget('الى', style: AppTextStyles.styleBold13),
                const SizedBox(width: 10),
                Expanded(
                  child: _PriceField(
                    controller: _minController,
                    onChanged: _onMinChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ── Range Slider ─────────────────────────────────────────────
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primaryDark,
                inactiveTrackColor: AppColors.grayscale400,
                thumbColor: AppColors.primaryDark,
                overlayColor: AppColors.primaryDark.withOpacity(0.15),
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: RangeSlider(
                values: _priceRange,
                min: 0,
                max: 500,
                onChanged: _onRangeChanged,
              ),
            ),

            // ── Slider labels ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    '\$${_priceRange.end.toInt()}',
                    style: AppTextStyles.styleSemiBold13.copyWith(
                      color: AppColors.green1_500,
                    ),
                  ),
                  AppTextWidget(
                    '\$${_priceRange.start.toInt()}',
                    style: AppTextStyles.styleSemiBold13.copyWith(
                      color: AppColors.green1_500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

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

class _PriceField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _PriceField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 3,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFCDD2DE)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        style: AppTextStyles.styleRegular13.copyWith(
          color: const Color(0xFF888FA0),
        ),
      ),
    );
  }
}
