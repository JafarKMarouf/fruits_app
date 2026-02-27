import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/get_user.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/custom_notification.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(AppImages.imagesProfileAvatar),
      title: AppTextWidget(
        text: AppLocalizations.of(context).goodMorning,
        style: AppTextStyles.styleRegular16.copyWith(
          color: AppColors.grayscale400,
        ),
      ),
      subtitle: AppTextWidget(
        text: getUser().name,
        style: AppTextStyles.styleBold16.copyWith(
          color: AppColors.grayscale950,
        ),
      ),
      trailing: const CustomNotification(),
    );
  }
}
