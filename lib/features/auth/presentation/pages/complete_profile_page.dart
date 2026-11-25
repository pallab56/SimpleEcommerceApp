import 'package:flutter/material.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/route/app_router.dart';

/// Complete Profile form screen.
///
/// Layout (matches CraftyBay mockup):
///  - CustomAppBar with back arrow + "Complete Profile"
///  - Subtitle
///  - First Name, Last Name, Mobile, City fields (single line)
///  - Shipping Address field (multi-line)
///  - "Complete" button
class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _shippingCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _mobileCtrl.dispose();
    _cityCtrl.dispose();
    _shippingCtrl.dispose();
    super.dispose();
  }

  void _onComplete() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // TODO: Dispatch complete-profile event to AuthBloc
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.mainNav,
      (_) => false,
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.completeProfileTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Subtitle ──────────────────────────────────────────────
                const Text(
                  AppStrings.completeProfileSubtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // ── First Name ────────────────────────────────────────────
                CustomTextField(
                  controller: _firstNameCtrl,
                  hintText: AppStrings.firstNameHint,
                  textInputAction: TextInputAction.next,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 16),

                // ── Last Name ─────────────────────────────────────────────
                CustomTextField(
                  controller: _lastNameCtrl,
                  hintText: AppStrings.lastNameHint,
                  textInputAction: TextInputAction.next,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 16),

                // ── Mobile ────────────────────────────────────────────────
                CustomTextField(
                  controller: _mobileCtrl,
                  hintText: AppStrings.mobileHint,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 16),

                // ── City ──────────────────────────────────────────────────
                CustomTextField(
                  controller: _cityCtrl,
                  hintText: AppStrings.cityHint,
                  textInputAction: TextInputAction.next,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 16),

                // ── Shipping Address (multi-line) ─────────────────────────
                CustomTextField(
                  controller: _shippingCtrl,
                  hintText: AppStrings.shippingAddressHint,
                  maxLines: 4,
                  textInputAction: TextInputAction.done,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 24),

                // ── Complete button ───────────────────────────────────────
                CustomButton(
                  text: AppStrings.complete,
                  onPressed: _onComplete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
