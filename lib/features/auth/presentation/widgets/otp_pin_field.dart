import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';

/// Simple 4-digit OTP input.
///
/// Uses one hidden [TextField] with 4 visual boxes drawn on top.
/// Calls [onCompleted] when all digits are entered.
class OtpPinField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;

  const OtpPinField({
    super.key,
    this.length = 4,
    this.onCompleted,
  });

  @override
  State<OtpPinField> createState() => _OtpPinFieldState();
}

class _OtpPinFieldState extends State<OtpPinField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
    if (_controller.text.length == widget.length) {
      _focusNode.unfocus();
      widget.onCompleted?.call(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Hidden real input
          Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              maxLength: widget.length,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),

          // Visual boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (i) {
              final hasValue = i < _controller.text.length;
              final isActive = _focusNode.hasFocus && i == _controller.text.length;

              return Container(
                width: 56,
                height: 56,
                margin: EdgeInsets.only(right: i < widget.length - 1 ? 12 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isActive ? AppColors.primary : AppColors.border,
                    width: isActive ? 1.5 : 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  hasValue ? _controller.text[i] : '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
