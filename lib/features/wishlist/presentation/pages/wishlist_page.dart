import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../bloc/wishlist_cubit.dart';
import '../bloc/wishlist_state.dart';
import '../widgets/wishlist_grid.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().loadWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Wishlist',
        showBackButton: false,
      ),
      body: BlocConsumer<WishlistCubit, WishlistState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.items.isNotEmpty) {
            SnackBarHelper.showError(context, state.errorMessage!);
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
                    onPressed: () =>
                        context.read<WishlistCubit>().loadWishlist(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state.items.isEmpty) {
            return const Center(child: Text('Your wishlist is empty'));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<WishlistCubit>().loadWishlist(),
            child: WishlistGrid(items: state.items),
          );
        },
      ),
    );
  }
}
