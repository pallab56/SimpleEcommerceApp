import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/category.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/product_card.dart';
import '../../../../core/route/app_router.dart';
import '../bloc/category_products_cubit.dart';
import '../bloc/category_products_state.dart';

/// Filtered product grid for a selected category (e.g. "Electronics").
/// Receives a [Category] via Navigator arguments.
class CategoryProductsPage extends StatelessWidget {
  final Category category;

  const CategoryProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryProductsCubit()..loadProducts(category.id),
      child: Scaffold(
        appBar: CustomAppBar(title: category.name),
        body: BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
          builder: (context, state) {
            if (state is CategoryProductsLoading ||
                state is CategoryProductsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CategoryProductsError) {
              return Center(child: Text(state.message));
            }
            if (state is CategoryProductsLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found'));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (_, i) => ProductCard(
                  product: state.products[i],
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productDetails,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
