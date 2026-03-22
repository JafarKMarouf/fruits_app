import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/app_text_widget.dart';

class AddressStep extends StatefulWidget {
  const AddressStep({super.key});

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  bool _saveAddress = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        AppTextFormField(
          hintText: 'الاسم كامل',
          textInputType: TextInputType.name,
          textInputAction: TextInputAction.next,
          showShadow: false,
          validator: (_) => null,
        ),
        const SizedBox(height: 12),
        AppTextFormField(
          hintText: 'البريد الإلكتروني',
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          showShadow: false,
          validator: (_) => null,
        ),
        const SizedBox(height: 12),
        AppTextFormField(
          hintText: 'العنوان',
          textInputType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          showShadow: false,
          validator: (_) => null,
        ),
        const SizedBox(height: 12),
        AppTextFormField(
          hintText: 'المدينه',
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          showShadow: false,
          validator: (_) => null,
        ),
        const SizedBox(height: 12),
        AppTextFormField(
          hintText: 'رقم الطابق , رقم الشقه ..',
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.done,
          showShadow: false,
          validator: (_) => null,
        ),
        const SizedBox(height: 16),
        _SaveAddressToggle(
          value: _saveAddress,
          onChanged: (val) => setState(() => _saveAddress = val),
        ),
      ],
    );
  }
}

class _SaveAddressToggle extends StatelessWidget {
  const _SaveAddressToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .start,
      children: [
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: AppColors.green1_500,
          inactiveThumbColor: AppColors.grayscale500,
        ),
        const SizedBox(width: 8),
        AppTextWidget(
          'حفظ العنوان',
          style: AppTextStyles.styleSemiBold13.copyWith(
            color: AppColors.grayscale400,
          ),
        ),
      ],
    );
  }
}
