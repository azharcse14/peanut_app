import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:peanut_app/core/constants/app_constants.dart';
import 'package:peanut_app/core/constants/colors.dart';

class KButtonFullWidth extends StatelessWidget {
  const KButtonFullWidth({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.bgColor = kBlueColor,
    this.textColor = kWhiteColor,
    this.borderRadius = 80,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final Color bgColor;
  final bool isLoading;
  final Color textColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitThreeBounce(
      color: Colors.white,
      size: 20.0,
    );
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.zero,
      onPressed: isLoading ? null : onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
        ),
        child: Center(
          child: isLoading
              ? spinkit
              : Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppConstants.fontFamily,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
