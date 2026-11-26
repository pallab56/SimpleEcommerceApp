import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_review.dart';
import '../../domain/usecases/get_product_reviews.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final GetProductReviews _getProductReviews;
  final CreateReview _createReview;

  ReviewCubit({
    required GetProductReviews getProductReviews,
    required CreateReview createReview,
  })  : _getProductReviews = getProductReviews,
        _createReview = createReview,
        super(const ReviewState());

  Future<void> loadReviews(String productId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getProductReviews(productId);
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.message),
      ),
      (reviews) => emit(
        state.copyWith(reviews: reviews, isLoading: false, errorMessage: null),
      ),
    );
  }

  Future<void> submitReview({
    required String productId,
    required String comment,
    required double rating,
  }) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        submitSuccess: false,
      ),
    );

    final result = await _createReview(
      CreateReviewParams(
        productId: productId,
        comment: comment,
        rating: rating,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isSubmitting: false, errorMessage: failure.message),
      ),
      (newReview) => emit(
        state.copyWith(
          reviews: [newReview, ...state.reviews],
          isSubmitting: false,
          submitSuccess: true,
        ),
      ),
    );
  }
}
