import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity.dart';

import '../../../../../core/helper/show_messages_bar.dart';

class CheckoutController extends ChangeNotifier {
  CheckoutController() {
    pageController = PageController();
    pageController.addListener(_onPageChanged);
  }

  // ── Page state ───────────────────────────────────────────
  late final PageController pageController;
  int currentStepIndex = 0;

  final formKey = GlobalKey<FormState>();
  final autovalidateNotifier = ValueNotifier(AutovalidateMode.disabled);

  void _onPageChanged() {
    final page = pageController.page?.toInt();
    if (page != null && page != currentStepIndex) {
      currentStepIndex = page;
      notifyListeners();
    }
  }

  // ── Validation + navigation ──────────────────────────────
  void validateAndGoNext(BuildContext context) {
    final error = _validate(context);

    if (error == null) {
      _goToNextStep();
    } else if (error.isNotEmpty) {
      showErrorBar(context, error);
    }
  }

  /// Returns null on success, error message on failure.
  String? _validate(BuildContext context) {
    return switch (currentStepIndex) {
      0 => _validateShipping(context),
      1 => _validateAddress(),
      _ => null,
    };
  }

  String? _validateShipping(BuildContext context) {
    final isPicked = context.read<OrderInputEntity>().payWithCash != null;
    return isPicked ? null : 'يرجى تحديد طريقة الدفع';
  }

  String? _validateAddress() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState!.save();
      return null;
    }
    autovalidateNotifier.value = AutovalidateMode.always;
    return '';
  }

  void _goToNextStep() {
    pageController.animateToPage(
      currentStepIndex + 1,
      duration: const Duration(milliseconds: kAnimatedDuration),
      curve: kCurves,
    );
  }

  void goBack(int index) {
    if (currentStepIndex == 0) return;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: kAnimatedDuration),
      curve: kCurves,
    );
  }

  @override
  void dispose() {
    pageController.removeListener(_onPageChanged);
    pageController.dispose();
    autovalidateNotifier.dispose();
    super.dispose();
  }
}
