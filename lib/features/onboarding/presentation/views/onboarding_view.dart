import 'package:flutter/material.dart';
import 'package:fruits_app/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  static const routeName = 'on-boarding';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: OnboardingViewBody());
  }
}
