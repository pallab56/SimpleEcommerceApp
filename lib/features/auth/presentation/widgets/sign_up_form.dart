import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/form_validators.dart';
import '../bloc/auth_bloc.dart';
import 'auth_password_field.dart';

class SignUpForm extends StatefulWidget {
  final bool isLoading;

  const SignUpForm({
    super.key,
    required this.isLoading,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.isLoading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
          AuthSignUpEvent(
            firstName: _firstNameCtrl.text.trim(),
            lastName: _lastNameCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text,
            phone: _phoneCtrl.text.trim(),
            city: _cityCtrl.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _firstNameCtrl,
            hintText: 'First Name',
            textInputAction: TextInputAction.next,
            validator: (v) =>
                FormValidators.requiredField(v, 'Enter your first name'),
          ),
          const SizedBox(height: 14),
          CustomTextField(
            controller: _lastNameCtrl,
            hintText: 'Last Name',
            textInputAction: TextInputAction.next,
            validator: (v) =>
                FormValidators.requiredField(v, 'Enter your last name'),
          ),
          const SizedBox(height: 14),
          CustomTextField(
            controller: _emailCtrl,
            hintText: AppStrings.emailHint,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: FormValidators.email,
          ),
          const SizedBox(height: 14),
          AuthPasswordField(
            controller: _passwordCtrl,
            validator: FormValidators.password,
          ),
          const SizedBox(height: 14),
          CustomTextField(
            controller: _phoneCtrl,
            hintText: 'Mobile Number',
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: FormValidators.phone,
          ),
          const SizedBox(height: 14),
          CustomTextField(
            controller: _cityCtrl,
            hintText: 'City',
            textInputAction: TextInputAction.done,
            validator: (v) =>
                FormValidators.requiredField(v, 'Enter your city'),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Sign Up',
            isLoading: widget.isLoading,
            onPressed: widget.isLoading ? null : _submit,
          ),
        ],
      ),
    );
  }
}
