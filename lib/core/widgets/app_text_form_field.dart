import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    required this.textInputType,
    this.textInputAction,
    this.validator,
    this.showShadow = true,
    this.onSaved,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool showShadow;
  final void Function(String?)? onSaved;

  InputBorder _buildBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color ?? AppColors.border, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showShadow
          ? const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            )
          : null,
      child: TextFormField(
        validator:
            validator ??
            (value) => (value == null || value.isEmpty)
                ? AppLocalizations.of(context).requiredField
                : null,
        onSaved: onSaved,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        textInputAction: textInputAction ?? TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF9FAFA),
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: AppTextStyles.styleBold13.copyWith(
            color: AppColors.grayscale400,
          ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          errorBorder: _buildBorder(AppColors.error),
          focusedErrorBorder: _buildBorder(AppColors.error),
          errorStyle: AppTextStyles.styleBold13.copyWith(
            color: AppColors.error,
          ),
        ),
      ),
    );
  }
}
