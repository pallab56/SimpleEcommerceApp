import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/product_card.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../bloc/wishlist_cubit.dart';
import '../bloc/wishlist_state.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WishlistCubit()..loadWishlist(),
      child: const _WishlistView(),
    );
  }
}

class _WishlistView extends StatelessWidget {
  const _WishlistView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.wishlist,
        showBackButton: false,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading || state is WishlistInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WishlistError) {
            return Center(child: Text(state.message));
          }
          if (state is WishlistLoaded) {
            if (state.items.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Color(0xFFBDBDBD)),
                    SizedBox(height: 16),
                    Text(
                      'Your wishlist is empty',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8E8E8E)),
                    ),
                  ],
                ),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (_, i) {
                final product = state.items[i];
                return ProductCard(
                  product: product,
                  isWishlisted: true,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.productDetails),
                  onWishlistTap: () => context
                      .read<WishlistCubit>()
                      .removeFromWishlist(product.id),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
