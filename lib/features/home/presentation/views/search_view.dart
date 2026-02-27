import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const routeName = 'search-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SearchViewBody());
  }
}
