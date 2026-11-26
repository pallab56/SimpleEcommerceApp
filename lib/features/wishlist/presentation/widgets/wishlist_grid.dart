import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/product_card.dart';
import '../../../../core/route/app_router.dart';
import '../../domain/entities/wishlist_item.dart';
import '../bloc/wishlist_cubit.dart';

class WishlistGrid extends StatelessWidget {
  final List<WishlistItem> items;

  const WishlistGrid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (_, index) {
        final product = items[index].product;
        return ProductCard(
          product: product,
          isWishlisted: true,
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
  }
}
