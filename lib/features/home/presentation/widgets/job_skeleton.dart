import 'package:flutter/material.dart';
import 'package:peanut_app/core/presentation/widgets/shimmer/shimmer_bg.dart';

class JobSkeleton extends StatelessWidget {
  const JobSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: SizedBox(height: 160, child: ShimmerBg()),
            );
          },
        ),
      ),
    );
  }
}
