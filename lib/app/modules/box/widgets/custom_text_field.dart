import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String labelExample;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.labelExample,
    required this.controller,
    required this.validator,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF262626),
                    letterSpacing: 1.5)),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            return TextFormField(
              controller: controller,
              validator: validator,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  label: Text(controller.text.isEmpty ? labelExample : label),
                  labelStyle: TextStyle(color: Colors.grey[500])),
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  overflow: TextOverflow.clip,
                  color: Colors.black),
            );
          },
        ),
      ],
    );
  }
}
