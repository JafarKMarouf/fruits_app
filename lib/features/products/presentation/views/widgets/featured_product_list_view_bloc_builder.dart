import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubits/featured_products/featured_product_cubit.dart';
import 'package:fruits_app/core/helper/get_mock_products.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/featured_product_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/widgets/custom_error_widget.dart';

class FeaturedProductListViewBlocBuilder extends StatelessWidget {
  const FeaturedProductListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedProductCubit, FeaturedProductState>(
      builder: (context, state) {
        if (state is FeaturedProductSuccess) {
          return FeaturedProductListView(products: state.products);
        } else if (state is FeaturedProductFailure) {
          return CustomErrorWidget(
            errorMessage: state.errMessage,
            onRetry: () {
              context.read<FeaturedProductCubit>().getFeaturedProducts();
            },
          );
        } else {
          return Skeletonizer(
            enabled: true,
            child: FeaturedProductListView(products: getMockProducts()),
          );
        }
      },
    );
  }
}
