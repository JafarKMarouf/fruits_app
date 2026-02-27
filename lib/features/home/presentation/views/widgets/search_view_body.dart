import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/custom_main_app_bar.dart';
import 'package:fruits_app/core/widgets/search_text_field.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/no_result_body.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/search_without_result.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            SizedBox(height: kTopPadding),
            CustomMainAppBar(title: 'البحث'),
            SizedBox(height: 16),
            SearchTextField(),
            SearchWithoutResult(),
            Spacer(flex: 2),
            NoResultBody(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
