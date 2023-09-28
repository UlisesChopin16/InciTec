import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget{

  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final Color fillColor;
  final Color colorTextLabelStyle;
  final Widget? prefixIcon;
  final String labelText;
  final Widget? suffixIcon;

  const MyTextFormField({
    super.key,
    required this.obscureText,
    required this.validator,
    this.onTap,
    required this.fillColor,
    required this.colorTextLabelStyle,
    required this.prefixIcon,
    required this.labelText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      validator: validator,
      onTap: onTap,
      obscureText: obscureText,
      style:  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: fillColor,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: TextStyle(color: colorTextLabelStyle),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
              color: fillColor,
              width: 2.0
            ),
        ),
      ),
    );
  }
}