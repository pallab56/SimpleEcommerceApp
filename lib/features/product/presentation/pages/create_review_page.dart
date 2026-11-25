import 'package:flutter/material.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

class CreateReviewPage extends StatelessWidget {
  CreateReviewPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _reviewCtrl = TextEditingController();

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? AppStrings.fieldRequired : null;

  void _onSubmit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // TODO: dispatch CreateReview event
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.createReview),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              const _FieldLabel('First Name'),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _firstNameCtrl,
                hintText: AppStrings.firstNameHint,
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 16),

              // Last Name
              const _FieldLabel('Last Name'),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _lastNameCtrl,
                hintText: AppStrings.lastNameHint,
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 16),

              // Rating row
              const _FieldLabel('Rating'),
              const SizedBox(height: 8),
              const _RatingRow(),
              const SizedBox(height: 16),

              // Review text
              const _FieldLabel('Write Review'),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _reviewCtrl,
                hintText: AppStrings.writeReview,
                maxLines: 5,
                textInputAction: TextInputAction.done,
                validator: _required,
              ),
              const SizedBox(height: 28),

              CustomButton(
                text: AppStrings.submit,
                onPressed: () => _onSubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

/// Interactive star rating row (Cubit-free: simple StatefulWidget is fine
/// for this isolated, single-widget piece of UI state).
class _RatingRow extends StatefulWidget {
  const _RatingRow();
  @override
  State<_RatingRow> createState() => _RatingRowState();
}

class _RatingRowState extends State<_RatingRow> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return GestureDetector(
          onTap: () => setState(() => _rating = i + 1),
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              i < _rating ? Icons.star : Icons.star_border,
              color: AppColors.star,
              size: 32,
            ),
          ),
        );
      }),
    );
  }
}
