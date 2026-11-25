import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/product_card.dart';
import '../../../../core/common/widgets/section_header.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_category_list.dart';
import '../widgets/promo_banner_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHome(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

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
            return Center(child: Text(state.message));
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

            // Promo banner
            const PromoBannerSlider(),
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
              onCategoryTap: (cat) => Navigator.pushNamed(
                context,
                AppRoutes.categoryProducts,
                arguments: cat,
              ),
            ),
            const SizedBox(height: 20),

            // Popular section
            SectionHeader(title: AppStrings.popular, onSeeAll: () {}),
            const SizedBox(height: 12),
            _ProductGrid(products: state.popularProducts),
            const SizedBox(height: 20),

            // Special section
            SectionHeader(title: AppStrings.special, onSeeAll: () {}),
            const SizedBox(height: 12),
            _ProductGrid(products: state.specialProducts),
            const SizedBox(height: 20),

            // New section
            SectionHeader(title: AppStrings.newArrival, onSeeAll: () {}),
            const SizedBox(height: 12),
            _ProductGrid(products: state.newProducts),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// 2-column product grid used for every section on the Home page.
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
      itemBuilder: (_, i) => ProductCard(
        product: products[i],
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.productDetails),
      ),
    );
  }
}
