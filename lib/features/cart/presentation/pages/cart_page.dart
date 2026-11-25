import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/cart_cubit.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/checkout_bottom_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.cart,
        showBackButton: false,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartLoaded) {
            if (state.items.isEmpty) return _emptyCart();
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.items.length,
                    itemBuilder: (context, i) {
                      final item = state.items[i];
                      return CartItemCard(
                        item: item,
                        onIncrement: () =>
                            context.read<CartCubit>().increment(item.product.id),
                        onDecrement: () =>
                            context.read<CartCubit>().decrement(item.product.id),
                        onRemove: () =>
                            context.read<CartCubit>().remove(item.product.id),
                      );
                    },
                  ),
                ),
                CheckoutBottomBar(
                  total: state.total,
                  onCheckout: () {},
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _emptyCart() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.textHint),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
