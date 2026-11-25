import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/route/app_router.dart';

class CompleteProfilePage extends StatelessWidget {
  CompleteProfilePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _shippingCtrl = TextEditingController();

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? AppStrings.fieldRequired : null;

  void _onComplete(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // TODO: dispatch CompleteProfile event to AuthBloc
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.mainNav,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                const AppLogo(width: 100),
                const SizedBox(height: 16),

                // Title
                Text(
                  AppStrings.completeProfileTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  AppStrings.completeProfileSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                CustomTextField(
                  controller: _firstNameCtrl,
                  hintText: AppStrings.firstNameHint,
                  textInputAction: TextInputAction.next,
                  validator: _required,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _lastNameCtrl,
                  hintText: AppStrings.lastNameHint,
                  textInputAction: TextInputAction.next,
                  validator: _required,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _mobileCtrl,
                  hintText: AppStrings.mobileHint,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: _required,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _cityCtrl,
                  hintText: AppStrings.cityHint,
                  textInputAction: TextInputAction.next,
                  validator: _required,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _shippingCtrl,
                  hintText: AppStrings.shippingAddressHint,
                  maxLines: 4,
                  textInputAction: TextInputAction.done,
                  validator: _required,
                ),
                const SizedBox(height: 24),

                CustomButton(
                  text: AppStrings.complete,
                  onPressed: () => _onComplete(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
