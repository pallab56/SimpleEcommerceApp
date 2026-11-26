import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/product_card.dart';
import '../../../../core/route/app_router.dart';
import '../../../../init_dependencies.dart';
import '../../domain/entities/category.dart';
import '../bloc/category_products_cubit.dart';
import '../bloc/category_products_state.dart';
import '../constants/category_constants.dart';

class CategoryProductsPage extends StatelessWidget {
  final Category category;

  const CategoryProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<CategoryProductsCubit>()..loadProducts(category.id),
      child: Scaffold(
        appBar: CustomAppBar(title: category.name),
        body: BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
          builder: (context, state) {
            if (state is CategoryProductsLoading ||
                state is CategoryProductsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CategoryProductsError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(
                      height: CategoryConstants.productGridSpacing,
                    ),
                    ElevatedButton(
                      onPressed: () => context
                          .read<CategoryProductsCubit>()
                          .loadProducts(category.id),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is CategoryProductsLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return RefreshIndicator(
                onRefresh: () => context
                    .read<CategoryProductsCubit>()
                    .loadProducts(category.id),
                child: GridView.builder(
                  padding: const EdgeInsets.all(
                    CategoryConstants.screenPadding,
                  ),
                  itemCount: state.products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: CategoryConstants.productGridColumns,
                    mainAxisSpacing: CategoryConstants.productGridSpacing,
                    crossAxisSpacing: CategoryConstants.productGridSpacing,
                    childAspectRatio:
                        CategoryConstants.productChildAspectRatio,
                  ),
                  itemBuilder: (_, index) {
                    final product = state.products[index];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.productDetails,
                        arguments: product.id,
                      ),
                    );
                  },
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
