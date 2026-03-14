import 'package:flutter/material.dart';

class ItemActionButton extends StatefulWidget {
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
  State<ItemActionButton> createState() => _ItemActionButtonState();
}

class _ItemActionButtonState extends State<ItemActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 150),
          lowerBound: 0.0,
          upperBound: 0.2,
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onTap == null) return;

    _controller.forward().then((_) {
      _controller.reverse();
    });

    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final scale = 1 - _controller.value;

    return GestureDetector(
      onTap: _handleTap,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.backgroundColor,
            boxShadow: [
              if (_controller.isAnimating)
                BoxShadow(
                  color: widget.backgroundColor.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Icon(widget.icon, color: widget.iconColor, size: 20),
        ),
      ),
    );
  }
}
