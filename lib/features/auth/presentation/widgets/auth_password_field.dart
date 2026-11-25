import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/password_visibility_cubit.dart';

class AuthPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;

  const AuthPasswordField({
    super.key,
    required this.controller,
    this.hintText = AppStrings.passwordHint,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isObscured) {
        return CustomTextField(
          controller: controller,
          hintText: hintText,
          obscureText: isObscured,
          textInputAction: textInputAction,
          validator: validator,
          onSubmitted: onSubmitted,
          suffixIcon: IconButton(
            icon: Icon(
              isObscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textSecondary,
              size: 20,
            ),
            onPressed: () =>
                context.read<PasswordVisibilityCubit>().toggle(),
          ),
        );
      },
    );
  }
}
