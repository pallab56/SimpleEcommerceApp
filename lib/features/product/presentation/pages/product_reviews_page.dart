import 'package:ecommerceapp/features/product/domain/entities/review.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/app_colors.dart';

import '../widgets/review_card.dart';

/// Full list of product reviews with a bottom FAB to write a new one.
class ProductReviewsPage extends StatelessWidget {
  final List<Review> reviews;

  const ProductReviewsPage({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.reviews),
      body: reviews.isEmpty
          ? const Center(
              child: Text(
                'No reviews yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (_, i) => ReviewCard(review: reviews[i]),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${reviews.length} Reviews',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            FloatingActionButton.extended(
              heroTag: 'reviews_fab',
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.createReview),
              backgroundColor: AppColors.primary,
              label: const Text(
                AppStrings.createReview,
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              ),
              icon: const Icon(Icons.edit_outlined, color: AppColors.white),
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
