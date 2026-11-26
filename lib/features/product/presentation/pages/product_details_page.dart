import 'package:ecommerceapp/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:ecommerceapp/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../../../../init_dependencies.dart';
import '../../../wishlist/presentation/bloc/wishlist_cubit.dart';
import '../../../wishlist/presentation/bloc/wishlist_state.dart';
import '../bloc/product_cubit.dart';
import '../bloc/product_state.dart';
import '../widgets/bottom_price_cart_bar.dart';
import '../widgets/color_selector.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/quantity_controls.dart';
import '../widgets/size_selector.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<ProductCubit>()..loadProductDetails(productId),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Product Details'),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading || state is ProductInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ProductCubit>()
                          .loadProductDetails(productId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is ProductLoaded) {
              final product = state.product;
              final cubit = context.read<ProductCubit>();

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductImageCarousel(photos: product.photos),
                          const SizedBox(height: 16),

                          // Title + Quantity Stepper
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  product.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                ),
                              ),
                              const SizedBox(width: 8),
                              QuantityControls(
                                quantity: state.quantity,
                                onDecrement: cubit.decrementQuantity,
                                onIncrement: cubit.incrementQuantity,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Rating + Reviews + Wishlist Heart
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.star,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.productReviews,
                                  arguments: product.id,
                                ),
                                child: const Text('Reviews'),
                              ),
                              const Spacer(),
                              BlocBuilder<WishlistCubit, WishlistState>(
                                builder: (context, wishState) {
                                  final isWishlisted = wishState.isWishlisted(
                                    product.id,
                                  );
                                  return IconButton(
                                    icon: Icon(
                                      isWishlisted
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isWishlisted
                                          ? AppColors.error
                                          : AppColors.textSecondary,
                                    ),
                                    onPressed: () => context
                                        .read<WishlistCubit>()
                                        .toggleWishlist(product),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Colors
                          ColorSelector(
                            colors: product.colors,
                            selectedColor: state.selectedColor,
                            onColorSelected: cubit.selectColor,
                          ),

                          // Sizes
                          SizeSelector(
                            sizes: product.sizes,
                            selectedSize: state.selectedSize,
                            onSizeSelected: cubit.selectSize,
                          ),

                          // Description
                          const Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.description.isNotEmpty
                                ? product.description
                                : 'No description available.',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Price + Add To Cart Bar
                  BlocListener<CartCubit, CartState>(
                    listener: (context, cartState) {
                      if (cartState.errorMessage != null) {
                        SnackBarHelper.showError(
                          context,
                          cartState.errorMessage!,
                        );
                      } else if (cartState.actionMessage != null) {
                        SnackBarHelper.showSuccess(
                          context,
                          cartState.actionMessage!,
                        );
                      }
                    },
                    child: BottomPriceCartBar(
                      totalPrice: product.price * state.quantity,
                      onAddToCart: () => context.read<CartCubit>().addItem(
                        productId: product.id,
                        quantity: state.quantity,
                        color: state.selectedColor,
                        size: state.selectedSize,
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
