import 'package:flutter/material.dart';
import 'package:peanut_app/core/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBg extends StatelessWidget {
  const ShimmerBg({
    Key? key,
    this.width = 120,
    this.height = 25,
    this.radius = 10,
    this.color,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kLightGreyColor,
      highlightColor: kGreyColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 18),
          color: color ?? kLightGreyColor,
        ),
      ),
    );
  }
}

class ShimmerBgContainer extends StatelessWidget {
  const ShimmerBgContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 155,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.07999999821186066),
                offset: Offset(0, 8),
                blurRadius: 16)
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ));
  }
}
