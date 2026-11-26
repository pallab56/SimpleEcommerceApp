import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../../../../init_dependencies.dart';
import '../bloc/review_cubit.dart';
import '../bloc/review_state.dart';

class CreateReviewPage extends StatelessWidget {
  final String productId;

  const CreateReviewPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<ReviewCubit>(),
      child: _CreateReviewView(productId: productId),
    );
  }
}

class _CreateReviewView extends StatefulWidget {
  final String productId;

  const _CreateReviewView({required this.productId});

  @override
  State<_CreateReviewView> createState() => _CreateReviewViewState();
}

class _CreateReviewViewState extends State<_CreateReviewView> {
  final _formKey = GlobalKey<FormState>();
  final _commentCtrl = TextEditingController();
  double _selectedRating = 5.0;

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();
    context.read<ReviewCubit>().submitReview(
          productId: widget.productId,
          comment: _commentCtrl.text.trim(),
          rating: _selectedRating,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Create Review'),
      body: BlocConsumer<ReviewCubit, ReviewState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            SnackBarHelper.showError(context, state.errorMessage!);
          } else if (state.submitSuccess) {
            SnackBarHelper.showSuccess(context, 'Review submitted successfully');
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rating',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      final starValue = (index + 1).toDouble();
                      final isSelected = starValue <= _selectedRating;
                      return IconButton(
                        icon: Icon(
                          isSelected ? Icons.star : Icons.star_border,
                          color: AppColors.star,
                          size: 32,
                        ),
                        onPressed: () =>
                            setState(() => _selectedRating = starValue),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _commentCtrl,
                    hintText: 'Write your review...',
                    maxLines: 5,
                    validator: (v) =>
                        FormValidators.requiredField(v, 'Please write a review'),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Submit',
                    isLoading: state.isSubmitting,
                    onPressed: state.isSubmitting ? null : _onSubmit,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
