import 'package:flutter/material.dart';
import 'package:peanut_app/core/constants/app_constants.dart';
import 'package:peanut_app/core/constants/colors.dart';

class FormFieldWrapper extends StatelessWidget {
  const FormFieldWrapper({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontSize: 14,
            color: kDarkGreyColor,
          ),
        ),
        const SizedBox(height: 5),
        child,
      ],
    );
  }
}
