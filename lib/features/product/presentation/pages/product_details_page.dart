import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/quantity_stepper.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/product_cubit.dart';
import '../bloc/product_state.dart';
import '../widgets/bottom_price_cart_bar.dart';
import '../widgets/color_selector.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/review_card.dart';
import '../widgets/size_selector.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Color _selectedColor = ColorSelector.colors.first;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit()..loadProduct(widget.productId),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading || state is ProductInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ProductError) {
            return Scaffold(body: Center(child: Text(state.message)));
          }
          if (state is ProductLoaded) {
            return _buildPage(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, ProductLoaded state) {
    final cubit = context.read<ProductCubit>();

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.productDetails),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image carousel ───────────────────────────────────────────
            const ProductImageCarousel(imageCount: 3),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Title + rating row ──────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.product.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, size: 16, color: AppColors.star),
                      const SizedBox(width: 2),
                      Text(
                        state.product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${state.product.id}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Color selector ──────────────────────────────────────
                  const Text('Color',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 10),
                  ColorSelector(
                    selectedColor: _selectedColor,
                    onSelect: (c) => setState(() => _selectedColor = c),
                  ),
                  const SizedBox(height: 16),

                  // ── Size selector ───────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Size',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary)),
                      QuantityStepper(
                        quantity: state.quantity,
                        onDecrement: cubit.decrement,
                        onIncrement: cubit.increment,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizeSelector(
                    selectedSize: state.selectedSize,
                    onSelect: cubit.selectSize,
                  ),
                  const SizedBox(height: 20),

                  // ── Description ─────────────────────────────────────────
                  const Text('Description',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  const Text(
                    'Experience ultimate comfort with our Happy New Year Special Shoe. '
                    'Designed for all-day wear, it features premium materials and '
                    'ergonomic support. Available in multiple colors and sizes.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Reviews header + preview ────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppStrings.reviews} (${state.reviews.length})',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.productReviews,
                          arguments: state.reviews,
                        ),
                        child: const Text(
                          AppStrings.seeAll,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Show first 2 reviews
                  ...state.reviews
                      .take(2)
                      .map((r) => ReviewCard(review: r)),
                  const SizedBox(height: 80), // space for bottom bar
                ],
              ),
            ),
          ],
        ),
      ),

      // ── Bottom price + cart bar ─────────────────────────────────────────
      bottomNavigationBar: BottomPriceCartBar(
        price: state.product.price * state.quantity,
        onAddToCart: () {},
      ),

      // ── Create review FAB ───────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.createReview),
        backgroundColor: AppColors.primary,
        label: const Text(
          AppStrings.createReview,
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.edit_outlined, color: AppColors.white),
      ),
    );
  }
}
