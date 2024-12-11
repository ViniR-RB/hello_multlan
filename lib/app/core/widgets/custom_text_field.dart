import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';
import 'package:hellomultlan/app/core/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String labelExample;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? icon;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.label,
    required this.labelExample,
    required this.controller,
    required this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.icon,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.primaryColor,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),

        // Input Field with Shadow
        Stack(
          children: [
            // BoxShadow Background
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [AppTheme.boxShadowDefault],
              ),
              child: TextFormField(
                controller: widget.controller,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                obscureText: widget.isPassword ? _obscureText : false,
                showCursor: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  hintText: widget.controller.text.isEmpty
                      ? widget.labelExample
                      : widget.label,
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _obscureText
                                ? Colors.grey[600]
                                : AppColors.primaryColor,
                          ),
                        )
                      : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5), // Espaço entre o input e o erro

        // Error Message
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            if (widget.controller.text.length > 1) {
              final errorText = widget.validator(widget.controller.text) ?? '';
              return errorText.isNotEmpty
                  ? Text(
                      errorText,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    )
                  : const SizedBox.shrink();
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
