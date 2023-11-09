import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.validator,
    this.controller,
    this.formatter,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.keyBoardType = TextInputType.text,
    this.label,
    this.border = false,
    this.radius = 16.0,
  });

  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatter;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextInputType keyBoardType;
  final String? label;
  final bool border;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: formatter,
      textCapitalization: textCapitalization,
      keyboardType: keyBoardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        border: (border)
            ? OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)))
            : null,
      ),
    );
  }
}
