import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peanut_app/core/constants/app_constants.dart';
import 'package:peanut_app/core/constants/colors.dart';

class KTextField extends StatelessWidget {

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? hintText;
  final TextInputAction? inputAction;
  final EdgeInsets contentPadding;
  final int maxLines;

  const KTextField(
      {Key? key,
      required this.controller,
      this.prefixIcon,
      this.validator,
      this.keyboardType = TextInputType.name,
      this.onTap,
      this.suffixIcon,
      this.numberFormatters = false,
      this.obscureText = false,
      this.hintText,
      this.inputAction,
      this.maxLines = 1,
      this.contentPadding = const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      this.readOnly = false})
      : super(key: key);
  final bool obscureText, numberFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontFamily: AppConstants.fontFamily, fontSize: 14),
      validator: validator,
      cursorColor: kAccentColor,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintStyle: const TextStyle(
          fontFamily: AppConstants.fontFamily,
          color: kGreyColor,
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kAccentColor),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: kLightGreyColor),
          borderRadius: BorderRadius.circular(5),
        ),
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      obscureText: obscureText,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      inputFormatters: [
        if (numberFormatters)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
    );
  }
}
