import 'package:flutter/widgets.dart';

class ItemActionButton extends StatelessWidget {
  const ItemActionButton({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });
  final Color backgroundColor, iconColor;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
