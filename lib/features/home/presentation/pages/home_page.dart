import 'package:ecommerceapp/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:ecommerceapp/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/entities/category.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/common/widgets/product_card.dart';
import '../../../../core/common/widgets/section_header.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../../../../init_dependencies.dart';
import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_category_list.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/promo_banner_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<HomeCubit>()..loadHome(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  void _openCategoryProducts(BuildContext context, Category? category) {
    if (category == null) return;
    Navigator.pushNamed(
      context,
      AppRoutes.categoryProducts,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().loadHome(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is HomeLoaded) {
            return _buildContent(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeLoaded state) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().loadHome(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            HomeSearchBar(onTap: () {}),
            const SizedBox(height: 16),

            // Promo banner from API
            PromoBannerSlider(banners: state.banners),
            const SizedBox(height: 20),

            // All Categories header + horizontal list
            SectionHeader(
              title: AppStrings.allCategories,
              onSeeAll: () =>
                  Navigator.pushNamed(context, AppRoutes.categories),
            ),
            const SizedBox(height: 12),
            HomeCategoryList(
              categories: state.categories,
              onCategoryTap: (cat) => _openCategoryProducts(context, cat),
            ),
            const SizedBox(height: 20),

            // Popular section
            SectionHeader(
              title: AppStrings.popular,
              onSeeAll: () =>
                  _openCategoryProducts(context, state.popularCategory),
            ),
            const SizedBox(height: 12),
            _ProductGrid(products: state.popularProducts),
            const SizedBox(height: 20),

            // Special section
            SectionHeader(
              title: AppStrings.special,
              onSeeAll: () =>
                  _openCategoryProducts(context, state.specialCategory),
            ),
            const SizedBox(height: 12),
            _ProductGrid(products: state.specialProducts),
            const SizedBox(height: 20),

            // New section
            SectionHeader(
              title: AppStrings.newArrival,
              onSeeAll: () =>
                  _openCategoryProducts(context, state.newArrivalCategory),
            ),
            const SizedBox(height: 12),
            _ProductGrid(products: state.newProducts),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<Product> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (_, i) {
        final product = products[i];
        return BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, wishState) {
            return ProductCard(
              product: product,
              isWishlisted: wishState.isWishlisted(product.id),
              onWishlistTap: () =>
                  context.read<WishlistCubit>().toggleWishlist(product),
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.productDetails,
                arguments: product.id,
              ),
            );
          },
        );
      },
    );
  }
}
