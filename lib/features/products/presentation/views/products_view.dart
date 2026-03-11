import 'package:flutter/material.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/products_view_body.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  static const routeName = 'products-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ProductsViewBody());
  }
}
