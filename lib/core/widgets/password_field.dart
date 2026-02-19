import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/widgets/app_text_form_field.dart';

class PasswordField extends StatefulWidget {
  final void Function(String?)? onSaved;
  final bool showFieldShadows;

  const PasswordField({
    super.key,
    required this.onSaved,
    required this.showFieldShadows,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      showShadow: widget.showFieldShadows,
      onSaved: widget.onSaved,
      hintText: AppLocalizations.of(context).password,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(
          obscureText ? Icons.remove_red_eye : Icons.visibility_off,
          color: const Color(0xFFC9CECF),
        ),
      ),
    );
  }
}
