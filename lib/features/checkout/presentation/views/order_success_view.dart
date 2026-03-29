import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/core/widgets/bottom_nav_bar/app_shell.dart';

import '../../../../core/widgets/app_primary_button.dart';
import 'order_tracking_view.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key, required this.orderId});

  static const routeName = 'order_success';

  final String orderId;

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView>
    with TickerProviderStateMixin {
  // ── Animation controllers ────────────────────────────────
  late final AnimationController _scaleCtrl;
  late final AnimationController _checkCtrl;
  late final AnimationController _textCtrl;
  late final AnimationController _pulseCtrl;

  late final Animation<double> _scaleAnim;
  late final Animation<double> _checkAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _checkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnim = CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut);
    _checkAnim = CurvedAnimation(parent: _checkCtrl, curve: Curves.easeOut);
    _fadeAnim = CurvedAnimation(parent: _textCtrl, curve: Curves.easeIn);
    _pulseAnim = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _scaleCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _checkCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _textCtrl.forward();
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _checkCtrl.dispose();
    _textCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ── UI ───────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                const Spacer(),
                _buildBadge(),
                const SizedBox(height: 32),
                _buildTexts(),
                const Spacer(),
                _buildActions(),
                const SizedBox(height: kTopPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return ScaleTransition(
      scale: _scaleAnim,
      child: ScaleTransition(
        scale: _pulseAnim,
        child: FadeTransition(
          opacity: _checkAnim,
          child: SvgPicture.asset(AppImages.imagesOrderSuccess),
        ),
      ),
    );
  }

  Widget _buildTexts() {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(_fadeAnim),
        child: Column(
          children: [
            AppTextWidget(
              'تم بنجاح !',
              style: AppTextStyles.styleBold16.copyWith(
                color: AppColors.grayscale950,
              ),
            ),
            const SizedBox(height: 10),
            AppTextWidget(
              'رقم الطلب : #${widget.orderId}',
              style: AppTextStyles.styleSemiBold16.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Column(
        children: [
          AppPrimaryButton(
            text: 'تتبع الطلب',
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              OrderTrackingView.routeName,
              arguments: widget.orderId,
            ),
            // onPressed: () {},
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppShell.routeName,
              (_) => false,
            ),
            child: AppTextWidget(
              'الرئيسية',
              style: AppTextStyles.styleSemiBold16.copyWith(
                color: AppColors.green1_500,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.green1_500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
