import 'package:equatable/equatable.dart';
import '../../domain/entities/review.dart';

class ReviewState extends Equatable {
  final List<Review> reviews;
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final bool submitSuccess;

  const ReviewState({
    this.reviews = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.submitSuccess = false,
  });

  ReviewState copyWith({
    List<Review>? reviews,
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    bool? submitSuccess,
  }) {
    return ReviewState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      submitSuccess: submitSuccess ?? false,
    );
  }

  @override
  List<Object?> get props => [
        reviews,
        isLoading,
        isSubmitting,
        errorMessage,
        submitSuccess,
      ];
}
