import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.onTap, this.readOnly = false});
  final void Function()? onTap;
  final bool readOnly;

  InputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.white, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 9,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: AppLocalizations.of(context).searchAbout,
          prefixIcon: SizedBox(
            width: 20,
            child: Center(
              child: SvgPicture.asset(AppImages.imagesSearchNormal),
            ),
          ),
          hintStyle: AppTextStyles.styleRegular13.copyWith(
            color: AppColors.grayscale400,
          ),
          suffixIcon: SizedBox(
            width: 20,
            child: Center(child: SvgPicture.asset(AppImages.imagesFilter)),
          ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          disabledBorder: _buildBorder(),
        ),
      ),
    );
  }
}
