import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.textStyle,
  });

  final Color backgroundColor;
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : AppTextWidget(text: text, style: textStyle),
        ),
      ),
    );
  }
}
