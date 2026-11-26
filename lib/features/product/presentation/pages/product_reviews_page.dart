import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../init_dependencies.dart';
import '../bloc/review_cubit.dart';
import '../bloc/review_state.dart';
import '../widgets/review_card.dart';

class ProductReviewsPage extends StatelessWidget {
  final String productId;

  const ProductReviewsPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<ReviewCubit>()..loadReviews(productId),
      child: _ProductReviewsView(productId: productId),
    );
  }
}

class _ProductReviewsView extends StatelessWidget {
  final String productId;

  const _ProductReviewsView({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reviews'),
      body: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state.isLoading && state.reviews.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null && state.reviews.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.errorMessage!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ReviewCubit>().loadReviews(productId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: state.reviews.isEmpty
                    ? const Center(child: Text('No reviews yet. Be the first!'))
                    : RefreshIndicator(
                        onRefresh: () =>
                            context.read<ReviewCubit>().loadReviews(productId),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.reviews.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, index) =>
                              ReviewCard(review: state.reviews[index]),
                        ),
                      ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reviews (${state.reviews.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FloatingActionButton.small(
                      backgroundColor: AppColors.primary,
                      onPressed: () async {
                        final added = await Navigator.pushNamed(
                          context,
                          AppRoutes.createReview,
                          arguments: productId,
                        );
                        if (added == true && context.mounted) {
                          context.read<ReviewCubit>().loadReviews(productId);
                        }
                      },
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
