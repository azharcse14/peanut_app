import 'package:flutter/material.dart';
import 'package:peanut_app/core/constants/app_constants.dart';
import 'package:peanut_app/core/constants/colors.dart';

class KCheckBox extends StatelessWidget {
  const KCheckBox({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.color = kBlackColor,
    this.fontSize = 16,
  }) : super(key: key);

  final String title;
  final bool value;
  final Function onChanged;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      activeColor: kBlackColor,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: AppConstants.fontFamily,
          color: color,
          fontSize: fontSize,
        ),
      ),
      value: value,
      contentPadding: EdgeInsets.zero,
      onChanged: ((value) => onChanged()),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
