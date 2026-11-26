import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../bloc/cart_cubit.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/checkout_bottom_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Cart',
        showBackButton: false,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.items.isNotEmpty) {
            SnackBarHelper.showError(context, state.errorMessage!);
          }
          if (state.actionMessage != null) {
            SnackBarHelper.showSuccess(context, state.actionMessage!);
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null && state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.errorMessage!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<CartCubit>().loadCart(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final cubit = context.read<CartCubit>();

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: cubit.loadCart,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final item = state.items[index];
                      return CartItemCard(
                        item: item,
                        onIncrement: () => cubit.updateQuantity(
                          cartItemId: item.id,
                          newQuantity: item.quantity + 1,
                        ),
                        onDecrement: () => cubit.updateQuantity(
                          cartItemId: item.id,
                          newQuantity: item.quantity - 1,
                        ),
                        onDelete: () => cubit.removeItem(item.id),
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.productDetails,
                          arguments: item.product.id,
                        ),
                      );
                    },
                  ),
                ),
              ),
              CheckoutBottomBar(
                totalPrice: state.totalPrice,
                onCheckout: () => SnackBarHelper.showSuccess(
                  context,
                  'Proceeding to checkout (\$${state.totalPrice.toStringAsFixed(2)})',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
