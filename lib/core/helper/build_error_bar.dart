import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:toastification/toastification.dart';

void buildErrorBar(BuildContext context, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    title: AppTextWidget(text: message, style: AppTextStyles.styleSemiBold13),
    autoCloseDuration: const Duration(seconds: 5),
  );
}

void buildSuccessMessage(BuildContext context, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    title: AppTextWidget(text: message, style: AppTextStyles.styleSemiBold13),
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
  );
}
