import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Reusable bordered text field — used in Auth, Review, Search screens.
///
/// Respects the global `InputDecorationTheme` from [AppTheme] but lets
/// callers override per-instance properties like `hintText`, `prefixIcon`,
/// `obscureText`, `maxLines`, `keyboardType`, and `textInputAction`.
///
/// Usage:
/// ```dart
/// CustomTextField(
///   controller: _emailCtrl,
///   hintText: AppStrings.emailHint,
///   keyboardType: TextInputType.emailAddress,
/// )
/// ```
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool autofocus;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.readOnly = false,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      autofocus: autofocus,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
