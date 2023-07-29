import 'package:flutter/material.dart';
import 'package:peanut_app/core/helpers/widget_helper.dart';

Padding columnItem(String key, var value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customText(
          text: key,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        customText(
          text: ' : ',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        customText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ],
    ),
  );
}
